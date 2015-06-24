class AddColumnCreditAcctNoInEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :credit_acct_no, :string, :limit => 25
  end
end
