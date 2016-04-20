class ChangeLimitInFtCustomers < ActiveRecord::Migration
  def change
    change_column :ft_customers, :name, :string, :limit => 100, :comment => "the name of the customers"
    change_column :ft_customers, :customer_id, :string, :limit => 15, :null => true, :comment => "the ID of the customer"
    change_column :ft_customers, :identity_user_id, :string, :limit => 20, :null => false, :comment => "the User ID of Customer"
  end
end
