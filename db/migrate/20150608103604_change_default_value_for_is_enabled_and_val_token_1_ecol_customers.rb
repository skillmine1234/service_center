class ChangeDefaultValueForIsEnabledAndValToken1EcolCustomers < ActiveRecord::Migration
  def up
    change_column :ecol_customers, :val_token_1, :string, :default => "N"
    change_column :ecol_customers, :is_enabled, :string, :default => "Y"
  end
  
  def down
    change_column :ecol_customers, :val_token_1, :string, :default => nil
    change_column :ecol_customers, :is_enabled, :string, :default => "TRUE"
  end
end
