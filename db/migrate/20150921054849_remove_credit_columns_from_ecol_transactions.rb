class RemoveCreditColumnsFromEcolTransactions < ActiveRecord::Migration
  def change
    remove_column :ecol_transactions, :credit_status
    remove_column :ecol_transactions, :credit_result
  end
end
