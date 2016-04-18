class RemoveColumnFromFundsTransferCustomers < ActiveRecord::Migration
  def change
    remove_column :funds_transfer_customers, :account_no
    remove_column :funds_transfer_customers, :account_ifsc
    remove_column :funds_transfer_customers, :country
    remove_column :funds_transfer_customers, :address_line1
    remove_column :funds_transfer_customers, :address_line2
    remove_column :funds_transfer_customers, :address_line3
    remove_column :funds_transfer_customers, :mmid
    remove_column :funds_transfer_customers, :mobile_no
    remove_column :funds_transfer_customers, :tech_email_id
    remove_column :funds_transfer_customers, :ops_email_id
  end
end
