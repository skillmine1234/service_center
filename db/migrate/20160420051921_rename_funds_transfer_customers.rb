class RenameFundsTransferCustomers < ActiveRecord::Migration
  def up
    remove_index :funds_transfer_customers, :name
    remove_index :funds_transfers_customers, :name => "FT_cust_index_on_app_id"
    remove_index :funds_transfers_customers, :name => "FT_cust_index_on_customer_id"
    rename_table :funds_transfer_customers, :ft_customers
    add_index :ft_customers, :name
    add_index :ft_customers, [:app_id, :customer_id, :approval_status], :name => "FT_cust_index_on_app_id"
  end

  def down
    rename_table :ft_customers, :funds_transfer_customers
  end
end
