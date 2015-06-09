class ChangeCustomerCodeColumnLimit < ActiveRecord::Migration
  def up
    change_column :ecol_customers, :code, :string, :limit => 15
  end
  
  def down
    change_column :ecol_customers, :code, :string, :limit => 11
  end
end
