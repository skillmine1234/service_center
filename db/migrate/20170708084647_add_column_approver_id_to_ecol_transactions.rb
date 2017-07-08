class AddColumnApproverIdToEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :approver_id, :integer, comment: 'the id of the user who approves the override of this transaction'
  end
end
