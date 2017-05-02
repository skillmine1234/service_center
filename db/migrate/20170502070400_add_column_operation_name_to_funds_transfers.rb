class AddColumnOperationNameToFundsTransfers < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.table_exists? 'funds_transfers'
      add_column :funds_transfers, :operation_name, :string, limit: 50, comment: 'the name of the operation to which this request belongs to'
    end
  end
end
