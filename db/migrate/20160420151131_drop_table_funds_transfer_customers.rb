class DropTableFundsTransferCustomers < ActiveRecord::Migration
  def change
    drop_table :funds_transfer_customers
  end
end
