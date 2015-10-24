class ChangeColumnCreditAcctValFailInEcolCustomers < ActiveRecord::Migration
  def change
    change_column :ecol_customers, :credit_acct_val_fail, :string, :limit => 25, :null => true
  end
end
