class AddAllowAllAccountsToFtCustomers < ActiveRecord::Migration
  def change
    add_column :ft_customers, :allow_all_accounts, :string, :limit => 1, :null => false, :default => 'Y', :comment => "the flag to allow all accounts or restrict to a specified set in ft_cust_accounts"
  end
end
