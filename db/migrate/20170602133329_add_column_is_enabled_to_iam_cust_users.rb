class AddColumnIsEnabledToIamCustUsers < ActiveRecord::Migration
  def change
    add_column :iam_cust_users, :is_enabled, :string, limit: 1, comment: 'the flag which indicates whether this user is enabled or not'
  end
end
