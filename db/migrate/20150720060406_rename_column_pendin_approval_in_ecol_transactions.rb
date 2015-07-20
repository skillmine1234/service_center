class RenameColumnPendinApprovalInEcolTransactions < ActiveRecord::Migration
  def change
    rename_column :ecol_transactions, :pending_approval, :pending_confirmation
  end
end
