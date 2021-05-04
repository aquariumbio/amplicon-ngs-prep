# typed: false
# frozen_string_literal: true

needs 'Next Gen Prep/GetMetadataHelper'

class Protocol
  include GetMetadataHelper

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
      title 'Metadata Table'

      table metadata_table
    end

    {}
  end
end
