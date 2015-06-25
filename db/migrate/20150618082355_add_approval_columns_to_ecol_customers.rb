class AddApprovalColumnsToEcolCustomers < ActiveRecord::Migration
  def change
    add_column :ecol_customers, :approval_status, :string, :limit => 1, :default => 'U'
    add_column :ecol_customers, :last_action, :string, :limit => 1, :default => 'C'
    remove_index :ecol_customers, :name => 'code_unique_index'
    add_index :ecol_customers, [:code,:approval_status], :unique => true, :name => 'customer_index_on_status'
  end
end
