class ChangeDefaultValueOfAutoCreditAndAutoReturnInEcolCustomers < ActiveRecord::Migration
  def change
    change_column :ecol_customers, :auto_credit, :string, :limit => 1, :default => "Y"
    change_column :ecol_customers, :auto_return, :string, :limit => 1, :default => "Y"
  end
end
