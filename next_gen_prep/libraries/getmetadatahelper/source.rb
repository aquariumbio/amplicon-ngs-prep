# typed: false
# frozen_string_literal: true

needs 'Standard Libs/OperationHistory'
needs 'Sample Models/Primer'
needs 'Standard Libs/IlluminaAdapterSequence'

module GetMetadataHelper
  DNA_LIBRARY = 'DNA Library'

  def build_metadata_table(operation_histories:)
    header = %w[item_id basespace_name] + metadata_keys.map(&:first) + %w[barcode]
    metadata_table = [header]

    operation_histories.each do |item_id, operation_history|
      row = build_row(item_id: item_id, operation_history: operation_history)
      metadata_table.append(row)
    end
    metadata_table
  end

  def build_row(item_id:, operation_history:)
    row = [Item.find(item_id).to_s]
    row +=
    row += metadata_from_keys(operation_history: operation_history)
    row += barcode_from_primers(operation_history: operation_history)
    row
  end

  def barcode_from_primers(operation_history:)
    primer_names = operation_history.fetch_data('forward_primer')
    primer_names += operation_history.fetch_data('reverse_primer')
    sample_type = SampleType.find_by_name('Primer')
    primer_samples = Sample.where(name: primer_names, sample_type: sample_type)
    primers = primer_samples.map { |s| Primer.new(sample: s) }
    barcodes = primers.map { |p| IlluminaAdapterSequence.new(sequence: p.sequence).barcode }
    barcodes.compact
  end

  def metadata_from_keys(operation_history:)
    row = []
    metadata_keys.each do |k, u|
      d = operation_history.fetch_data(k)
      d.uniq! if u == 'unique'
      row.append(d.join(', '))
    end
    row
  end

  def metadata_keys
    [
      %w[yeast_library unique],
      %w[protease not_unique],
      %w[protease_concentration not_unique],
      %w[sort_count unique],
      %w[frac_positive unique],
      %w[software_tube_id unique],
      %w[concentration unique]
    ]
  end

  def setup_test(operations:)
    items = test_items

    operations.each do |op|
      raise "Test must use #{test_items.length} or fewer operations." unless items.present?

      item = items.shift
      op.input(DNA_LIBRARY).update_attributes(child_item_id: item.id, child_sample_id: item.sample_id)
    end
  end

  def test_items
    Item.find([
                432266,
                432267,
                432268
              ])
  end
end