class AddCustomerNameToIcCustomers < ActiveRecord::Migration
  def change
    add_column :ic_customers, :customer_name, :string, :limit=>100, :comment => "the name of the customer"
  end
end
