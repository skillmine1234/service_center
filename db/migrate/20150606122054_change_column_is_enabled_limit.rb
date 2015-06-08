class ChangeColumnIsEnabledLimit < ActiveRecord::Migration
  def up
    change_column :ecol_customers, :is_enabled, :string, :limit => 1 
  end
  
  def down
    change_column :ecol_customers, :is_enabled, :string, :limit => 15
  end
end
