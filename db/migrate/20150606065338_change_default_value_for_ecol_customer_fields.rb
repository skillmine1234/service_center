class ChangeDefaultValueForEcolCustomerFields < ActiveRecord::Migration
  def up
    change_column :ecol_customers, :val_token_2, :string, :defualt => nil
    change_column :ecol_customers, :token_3_type, :string, :default => "N"
  end
  
  def down
    change_column :ecol_customers, :val_token_2, :string, :defualt => "N"
    change_column :ecol_customers, :token_3_type, :string, :default => nil
  end
end
