class ChangeDefalutValueOfPendingApprovalInEcolTransaction < ActiveRecord::Migration
  def change
    change_column :ecol_transactions, :pending_approval, :string, :default => 'Y'
  end
end
