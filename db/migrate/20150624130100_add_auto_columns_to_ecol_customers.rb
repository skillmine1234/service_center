class AddAutoColumnsToEcolCustomers < ActiveRecord::Migration
  def change
    add_column :ecol_customers, :auto_credit, :string, :limit => 1, :default => 'N'
    add_column :ecol_customers, :auto_return, :string, :limit => 1, :default => 'N'
  end
end
