class AddColomnsToIamCustUsers < ActiveRecord::Migration
  def change
    add_column :iam_cust_users, :secondary_email, :string
    add_column :iam_cust_users, :secondary_mobile_no, :string
    add_column :iam_cust_users, :is_sms, :boolean, :default => false
    add_column :iam_cust_users, :is_email, :boolean, :default => false
  end
end
