# typed: false
# frozen_string_literal: true

# Devin Strickland
# dvn.strcklnd@gmail.com
#
# makes 96-well Primer Plate collection item from IDT spreadsheet (saved as .csv)

needs 'Standard Libs/UploadHelper'
needs 'Standard Libs/Debug'
needs 'Standard Libs/MatrixTools'
needs 'Standard Libs/AssociationManagement'
needs 'Next Gen Prep/PrimerPlateHelper'

class Protocol
  include AssociationManagement
  include MatrixTools
  include Debug
  include UploadHelper
  include PrimerPlateHelper

  # upload stuff
  DIRNAME = 'Unknown'
  TRIES = 3
  NUM_FILES = 1

  # IDT file format stuff
  NAME = 'Sequence Name'
  POS = 'Well Position'
  SEQ = 'Sequence'
  TM = 'Tm (50mM NaCl) C'
  PRODUCT = 'Product'
  MODS = 'Modifications and Services'
  CONC = 'Conc'
  VOLUME = 'Volume'
  BUFFER = 'Buffer'

  # Sample
  PROJECT = 'Primer Plate' # project description in Sample definition
  PRIMER = 'Primer' # type of Sample
  PRIMER_PLATE = '96-Well Primer Stock Plate'

  def main
    operations.each do |operation|
      if debug
        upload = nil
        vendor_description = CSV.parse(CSV_DEBUG, liberal_parsing: true, encoding: "ISO8859-1")
      else
        uploads = uploadData(DIRNAME, NUM_FILES, TRIES)
        upload = uploads.first
        vendor_description = CSV.read(open(upload.url), liberal_parsing: true, encoding: "ISO8859-1")
      end

      inspect vendor_description.first if debug

      vendor_description = format_data(vendor_description)

      inspect vendor_description.first if debug

      find_or_create_primers(vendor_description, operation)

      primer_plate = Collection.new_collection(PRIMER_PLATE)

      matrix = WellMatrix.create_empty(96, Collection::EMPTY)

      vendor_description.each do |md|
        inspect md['Sample'] if debug
        inspect md['Sample'].properties.fetch('Anneal Sequence') if debug
        matrix.set(md[POS], md['Sample'].id)
      end

      primer_plate.associate_matrix(matrix.to_array)
      associate_data(primer_plate, 'vendor_description', upload)

      show do
        title 'Primer Plate Creation Successful!'
        note "Please label the #{PRIMER_PLATE} with Item ID #{primer_plate}."
      end
    end

    operations.store

    {}
  end

  def find_or_create_primers(vendor_description, operation)
    sample_type = SampleType.find_by_name(PRIMER)

    vendor_description.each do |md|
      sample = Sample.where(name: md[NAME], sample_type: sample_type).first
      if sample
        found_sequence = sample.properties['Overhang Sequence'].to_s + sample.properties['Anneal Sequence'].to_s
        found_sequence = found_sequence.gsub(/\s/, '')
        raise "Aq entry found for #{md[NAME]}, but sequences do not match." unless found_sequence =~ /^#{md[SEQ]}$/i
      else
        desc = "#{md[PRODUCT]}, #{md[MODS]}, #{md[CONC]} in #{md[BUFFER]}"
        sample_attr = {
          sample_type_id: sample_type.id,
          description: desc,
          name: md[NAME],
          project: PROJECT,
          field_values: [
            { name: 'Anneal Sequence', value: md[SEQ] },
            { name: 'Overhang Sequence', value: '' },
            { name: 'T Anneal', value: md[TM] }
          ]
        }
        sample = Sample.creator(sample_attr, operation.plan.user)
      end
      md['Sample'] = sample
    end
  end

  def format_data(vendor_description)
    headers = vendor_description.shift
    formatted = []

    vendor_description.each do |row|
      row = row.map do |cell|
        cell.gsub('"', '').gsub('\xEF\xBB\xBF', '').gsub('[', '').gsub(']', '').strip if cell.respond_to?(:strip)
      end
      row = Hash[headers.zip(row)]

      raise "Name or Sequence Missing:\n#{row}" if row['Sequence'].blank? || row[NAME].blank?

      row['Sequence'] = row['Sequence'].gsub(/\s+/, '')
      formatted.append(row)
    end

    formatted
  end
end
