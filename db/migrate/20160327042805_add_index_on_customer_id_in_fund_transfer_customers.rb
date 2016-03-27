class AddIndexOnCustomerIdInFundTransferCustomers < ActiveRecord::Migration
  def change
    add_index :funds_transfer_customers, [:customer_id,:approval_status], :unique => true, :name => 'FT_cust_index_on_customer_id'
  end
end
