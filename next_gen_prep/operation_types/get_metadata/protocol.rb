# typed: false
# frozen_string_literal: true

needs 'Standard Libs/ProvenanceFinder'
needs 'Standard Libs/Debug'

class Protocol
  include Debug

  DNA_LIBRARY = 'DNA Library'

  def main
    setup_test(operations: operations) if debug

    ids_to_trace = operations.map { |op| op.input(DNA_LIBRARY).child_item_id }
    operation_histories = {}
    ids_to_trace.each do |item_id|
      operation_histories[item_id] = OperationHistoryFactory.new.from_item(
        item_id: item_id,
        stop_at: 'High-Efficiency Transformation NEW'
      )
    end

    metadata_table = build_metadata_table(operation_histories: operation_histories)
    show do
      title 'Demo Table'

      table metadata_table
    end

    {}
  end

  def build_metadata_table(operation_histories:)
    header = %w[item_id] + metadata_keys.map(&:first)
    metadata_table = [header]

    operation_histories.each do |item_id, operation_history|
      row = build_row(item_id: item_id, operation_history: operation_history)
      metadata_table.append(row)
    end
    metadata_table
  end

  def build_row(item_id:, operation_history:)
    row = [Item.find(item_id).to_s]
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
      %w[barcode unique]
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
                486_207,
                486_208,
                486_209,
                486_210,
                486_211,
                486_212,
                486_213,
                486_214
              ])
  end
end
