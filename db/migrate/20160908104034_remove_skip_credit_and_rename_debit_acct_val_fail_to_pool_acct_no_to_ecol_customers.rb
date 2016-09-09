class RemoveSkipCreditAndRenameDebitAcctValFailToPoolAcctNoToEcolCustomers < ActiveRecord::Migration
  def change
    remove_column :ecol_customers, :skip_credit
    rename_column :ecol_customers, :debit_acct_val_fail, :pool_acct_no
  end 
end
