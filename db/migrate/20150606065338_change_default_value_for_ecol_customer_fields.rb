class ChangeDefaultValueForEcolCustomerFields < ActiveRecord::Migration
  def up
    change_column :ecol_customers, :token_3_type, :string, :default => "N"
  end
  
  def down
    change_column :ecol_customers, :token_3_type, :string, :default => nil
  end
end
