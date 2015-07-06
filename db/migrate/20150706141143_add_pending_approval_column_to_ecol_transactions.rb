class AddPendingApprovalColumnToEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :pending_approval, :string, :limit => 1, :default => 'N'
    remove_column :ecol_transactions, :do_credit
    remove_column :ecol_transactions, :do_return
  end
end
