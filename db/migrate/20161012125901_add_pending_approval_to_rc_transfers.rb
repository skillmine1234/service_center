class AddPendingApprovalToRcTransfers < ActiveRecord::Migration
  def change
    add_column :rc_transfers, :pending_approval, :string, :limit => 1, :null => false, :default => 'Y', :comment => "the indicator that denotes whether a human approval is awaited (Y) or not (N)"
  end
end
