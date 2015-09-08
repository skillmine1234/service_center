class AddCustomerIdToEcolCustomers < ActiveRecord::Migration
  def change
    add_column :ecol_customers, :customer_id, :string, :limit => 50, :default => 0, :null => false
  end
end
