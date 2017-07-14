class AddColumnApproverIdToEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :approver_id, :integer, comment: 'the id of the user who approves the override of this transaction'
    add_column :ecol_transactions, :remarks, :string, limit: 255, comment: 'the remarks entered by the person who overrides the transaction manually'
  end
end
