class RenameColumnPendingConfirmation < ActiveRecord::Migration
  def change
    rename_column :ecol_transactions, :pending_confirmation, :pending_approval
  end
end
