class AddColumnValLastTokenToEcolCustomers < ActiveRecord::Migration
  def change
    remove_column :ecol_customers, :val_token_1_length
    remove_column :ecol_customers, :val_token_2_length
    rename_column :ecol_customers, :val_token_3_length, :val_last_token_length 
    change_column :ecol_customers, :credit_acct_val_fail, :string, :limit => 25, :null => false
  end
end
