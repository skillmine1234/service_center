class AddNewColumnsToEcolCustomers < ActiveRecord::Migration
  def change
    add_column :ecol_customers, :val_token_1_length, :string, :limit => 1, :default => 'N'
    add_column :ecol_customers, :val_token_2_length, :string, :limit => 1, :default => 'N'
    add_column :ecol_customers, :val_token_3_length, :string, :limit => 1, :default => 'N'
    add_column :ecol_customers, :token_1_starts_with, :string, :limit => 29
    add_column :ecol_customers, :token_1_contains, :string, :limit => 29
    add_column :ecol_customers, :token_1_ends_with, :string, :limit => 29
    add_column :ecol_customers, :token_2_starts_with, :string, :limit => 29
    add_column :ecol_customers, :token_2_contains, :string, :limit => 29
    add_column :ecol_customers, :token_2_ends_with, :string, :limit => 29
    add_column :ecol_customers, :token_3_starts_with, :string, :limit => 29
    add_column :ecol_customers, :token_3_contains, :string, :limit => 29
    add_column :ecol_customers, :token_3_ends_with, :string, :limit => 29
    rename_column :ecol_customers, :credit_acct_no, :credit_acct_val_pass
    add_column :ecol_customers, :credit_acct_val_fail, :string, :limit => 25
    add_column :ecol_customers, :val_rmtr_name, :string, :limit => 1, :default => 'N'
  end
end
