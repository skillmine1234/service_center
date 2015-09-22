class AddIndexOnEcolCustomers < ActiveRecord::Migration
  def change
    add_index :ecol_customers, [:code, :approval_status], :unique => true
  end
end
