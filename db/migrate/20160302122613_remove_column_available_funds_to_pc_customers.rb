class RemoveColumnAvailableFundsToPcCustomers < ActiveRecord::Migration
  def change
    remove_column :pc_customers, :available_funds
  end
end
