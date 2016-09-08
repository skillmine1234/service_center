class RemoveSkipCreditAndRenameDebitAcctValFailToPoolAcctNoToEcolCustomers < ActiveRecord::Migration
  def self.up
    remove_column :ecol_customers, :skip_credit
    rename_column :ecol_customers, :debit_acct_val_fail, :pool_acct_no
  end
  
  def self.down
    add_column :ecol_customers, :skip_credit
    rename_column :ecol_customers, :pool_acct_no, :debit_acct_val_fail
  end  
end
