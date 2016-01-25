class AddIndexesInFundsTransferCustomers < ActiveRecord::Migration
  def change
    add_index :funds_transfer_customers, :name
    add_index :funds_transfer_customers, :account_no
    add_index :funds_transfer_customers, :tech_email_id
    add_index :funds_transfer_customers, :mobile_no
  end
end
