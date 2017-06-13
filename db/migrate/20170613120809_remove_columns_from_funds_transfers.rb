class RemoveColumnsFromFundsTransfers < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.table_exists? 'funds_transfers'
      remove_column :funds_transfers, :operation_name
      remove_column :funds_transfers, :customer_name
      remove_column :funds_transfers, :account_mmid
      remove_column :funds_transfers, :registered_mobile_no
    end
  end
end
