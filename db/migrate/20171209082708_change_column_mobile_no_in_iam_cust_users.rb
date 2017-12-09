class ChangeColumnMobileNoInIamCustUsers < ActiveRecord::Migration
  def change
    change_column :iam_cust_users, :mobile_no, :string, limit: 20
  end
end
