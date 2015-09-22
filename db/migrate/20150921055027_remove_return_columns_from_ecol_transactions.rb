class RemoveReturnColumnsFromEcolTransactions < ActiveRecord::Migration
  def change
    remove_column :ecol_transactions, :return_status
    remove_column :ecol_transactions, :return_result
  end
end
