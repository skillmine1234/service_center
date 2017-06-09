class AddDefaultValueForIsEnabledInIamCustUsers < ActiveRecord::Migration
  def change
    change_column :iam_cust_users, :is_enabled, :string, default: 'Y'
  end
end
