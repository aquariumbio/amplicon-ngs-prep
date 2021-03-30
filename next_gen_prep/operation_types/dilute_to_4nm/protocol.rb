# SG
#
# dilute samples with known concentration to 4nM
needs 'Standard Libs/SortHelper'
needs 'Next Gen Prep/NextGenPrepHelper'
needs 'Standard Libs/Feedback'

class Protocol
  include Feedback
  include NextGenPrepHelper
  include SortHelper

  # M20 location
  NGS_BOX = 'NGS 4nM temp box in SF2'.freeze

  # I/O
  IN = 'DNA library in'.freeze
  OUT = 'DNA library out'.freeze

  SAMPLE_VOL_UL = 1 # uL, starting sample volume for calculations
  FINAL_VOL_UL = 10 # uL, minimal final volume for output stock
  MIN_VOL = 0.5 # minimal volume for pippeting
  TOLERANCE = 0.1 # allowed error in concentration
  FINAL_NMOL_PER_UL = (6 / 1e6) # target concentration, 4nM is 4/1e6 nmol/uL

  TEST_CONCENTRATIONS = [0.5, 0.6, 0.7, 0.719, 0.72, 0.8, 0.9, 1.0, 2.0, 4.0].freeze # used for debug
  TEST_BINS = %w[P1 P2 P3 P4 P5 P6 P7 P8 pos neg].freeze # used for debug
  TEST_BARCODES = %w[AAAAA TTTTT GGGGG CCCCC ATATAT CGCGCG ACACAC TGTGTG ATCGAT TGCATG].freeze # used for debug

  def main
    associate_random_barcodes(operations: operations, in_handle: IN) if debug

    ops_sorted = sortByMultipleIO(operations, ['in'], [IN], ['id'], ['item'])
    operations = ops_sorted

    if debug
      operations.map do |op|
        op.input(IN).item.associate(:concentration, TEST_CONCENTRATIONS.rotate!.first)
        op.input(IN).item.associate(:length, 270)
        op.input(IN).item.associate(:bin, TEST_BINS.rotate!.first)
        op.input(IN).item.associate(:barcode, TEST_BARCODES.rotate!.first)
      end
    end

    # get lengths of all fragments
    operations.each do |op|
      next if op.input(IN).sample.nil?

      nm = SampleType.find(op.input(IN).sample.sample_type_id).name # sample type
      case nm
      when 'DNA Library' # should have "Library Stock" object_type with associated "length"
        stock = find(:item, object_type: { name: 'Library Stock' },
                            sample: { name: op.input(IN).sample.name }).first
        op.temporary[:length] = stock.get(:length) unless stock.nil?
      end
    end

    # ask tech to enter missing lengths
    length_unknown = operations.select { |op| op.temporary[:length].nil? }
    if length_unknown.any?
      # get lengths for all samples for which length is not defined - ideally this should not be needed!!!
      show do
        title 'Enter the expected lengths in bp for these samples:'
        note 'Ask a lab manager if you do not know'
        table length_unknown.start_table
                            .custom_column(heading: 'Sample Name', checkable: true) { |op| op.input(IN).sample.name }
                            .get(:length, type: 'number', heading: 'Expected length (bp)', default: 1)
                            .end_table
      end
    end
    operations.each do |op|
      op.input(IN).item.associate :length, op.temporary[:length]
    end

    # get rid of operations with no concentration or length
    operations.each do |op|
      begin
        tmp = op.input(IN).item.get(:concentration)
      # show { note "conc=#{tmp}" } if debug
      rescue StandardError
        op.error(:no_concentration, 'The library has no concentration. Please Qubit and replan.')
        # TODO : move qubit code to library, call same code here
      end

      begin
        tmp = op.input(IN).item.get(:length)
        # show { note "length=#{tmp}" } if debug
      rescue StandardError
        op.error(:no_length, 'The library has no length')
      end
    end

    ops = operations.running
    operations = ops # all operations now have :concentration and :length

    operations.each do |op|
      if concentration_in_nmol(op.input(IN).item.get(:concentration).to_f,
                               op.input(IN).item.get(:length).to_f) < FINAL_NMOL_PER_UL
        op.error(:low_concentration, 'Concentration too low for NGS sequencing prep')
      end
    end

    unless operations.running.any?
      show { note 'No operations left in Dilute to 4nM, returning.' }
      return
    end

    # sort running ops so that input ids and sample labels are in consecutive order
    ops = sortByMultipleIO(operations.running, ['in'], [IN], ['id'], ['item'])
    operations = ops
    operations.make
    operations.retrieve

    # vortex and spin
    show do
      title 'Vortex and spin samples'
      check "Vortex and spin samples #{operations.map do |op|
                                         op.input(IN).item
                                       end.to_sentence} to mix contents thoroughly"
    end

    # find sample and dilution volumes
    # on high sample volume end of scale (low starting concentration) 1 jump off is ~(0.5uL/10uL) or ~5% change in concentration, ok
    # on low sample volume (high initial concentration) it is ~(0.5uL/5uL) or %10 off
    operations.each do |op|
      sample_volume = SAMPLE_VOL_UL.to_f
      water_volume = dilution_volume(op.input(IN).item.get(:concentration).to_f,
                                     op.input(IN).item.get(:length).to_f, SAMPLE_VOL_UL).to_f

      fac1 = 0 # for higher volume if final volume too low
      fac2 = 0 # for higher volume if sample concentration is high

      # make sure have enough (>5uL) for next dilution step
      fac1 = (FINAL_VOL_UL.to_f / (sample_volume + water_volume))
      # make sure there will not be more than ~10% error in sample concentration
      min_sample_vol = MIN_VOL.to_f / TOLERANCE
      fac2 = min_sample_vol / sample_volume

      fac = [fac1, fac2].max
      if fac > 1
        sample_volume = fac * sample_volume
        water_volume = fac * water_volume
      end

      op.associate(:sample_volume,
                   sample_volume.floor + MIN_VOL * ((sample_volume - sample_volume.floor) / MIN_VOL).round)
      op.associate(:water_volume,
                   water_volume.floor + MIN_VOL * ((water_volume - water_volume.floor) / MIN_VOL).round)
    end

    # prep samples
    show do
      title 'Dilute samples to 4nM (Transfer Water)'
      check "Grab #{operations.length} 1.5 mL tubes(s), label them <b>4 nM</b> on the side of the tube"
      check "Additionally label them #{operations.map { |op| op.output(OUT).item.to_s }.to_sentence}"
      note 'Prepare the following 4nM samples:'

      table operations.start_table
                      .output_item(OUT, heading: 'DNA Library (output)')
                      .custom_column(heading: 'Water volume (µL)', checkable: true) { |op| op.get(:water_volume) }
                      .end_table
    end

    show do
      title 'Dilute samples to 4nM (Transfer Sample)'
      check "Grab tubes #{operations.map { |op| op.output(OUT).item.to_s }.to_sentence}"
      note 'Transfer associated sample volume from input to output:'

      table operations.start_table
                      .input_item(IN, heading: 'DNA Library (input)')
                      .custom_column(heading: 'Sample volume (µL)', checkable: true) { |op| op.get(:sample_volume) }
                      .output_item(OUT, heading: 'DNA Library (output)')
                      .end_table
      check 'Vortex and spin <b>4 nM</b> samples to mix contents thoroughly'
    end

    operations.each do |op|
      op.output(OUT).item.move(NGS_BOX) # REMOVE THIS!!!!
      op.output(OUT).item.associate(:tag, '4 nM') # so not confused with 4ng/uL
    end

    operations.running.each do |op|
      txfr_barcode(op, IN, OUT)
      txfr_bin(op, IN, OUT)
    end

    display_barcode_associations(operations: operations, in_handle: IN, out_handle: OUT) if debug

    # display map
    show do
      title 'List of 4nM outputs'
      table operations.start_table
                      .output_item(OUT, heading: 'DNA Library (output)')
                      .custom_column(heading: 'name', checkable: false) do |op|
        op.output(OUT).item.sample.name.to_s
      end
        .custom_column(heading: 'bin', checkable: false) do |op|
        op.output(OUT).item.get(:bin) || 'N/A'
      end
        .custom_column(heading: 'Illumina index', checkable: false) do |op|
        op.output(OUT).item.get(:barcode) || 'N/A'
      end
        .end_table
    end

    operations.store

    get_protocol_feedback

    {}
  end

  #---------------------------------------------------------------
  # dilution == water volume, for given init. concentration, length, and sample volume. (final concentration is 4nM)
  #---------------------------------------------------------------
  def dilution_volume(conc, length, vol)
    vol * ((concentration_in_nmol(conc, length) / FINAL_NMOL_PER_UL) - 1)
  end

  #---------------------------------------------------------------
  # calculates concentration in nmol
  # input in ng/uL, output in nM/uL. assumes dsDNA:
  # nmols = (weight in ng) / (base pairs x 650 daltons)
  #---------------------------------------------------------------
  def concentration_in_nmol(conc_in_ng, length)
    conc_in_ng.to_f / (length * 650)
  end
end
