class ChangeColumnsInEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :invoice_no, :string, :limit => 28
    add_column :ecol_transactions, :validate_at, :datetime
    add_column :ecol_transactions, :credit_attempt_at, :datetime
    add_column :ecol_transactions, :returned_at, :datetime
    add_column :ecol_transactions, :return_status, :string, :limit => 1
    add_column :ecol_transactions, :return_ref, :string, :limit => 64
    add_column :ecol_transactions, :return_attempt_at, :datetime
    add_column :ecol_transactions, :return_attempt_no, :integer
    add_column :ecol_transactions, :settle_attempt_at, :datetime
    remove_column :ecol_transactions, :tokenized_at 
    remove_column :ecol_transactions, :tokenzation_status
  end
  
end
