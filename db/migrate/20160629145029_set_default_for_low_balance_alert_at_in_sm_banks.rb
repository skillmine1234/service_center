class SetDefaultForLowBalanceAlertAtInSmBanks < ActiveRecord::Migration
  def change
    change_column :sm_banks, :low_balance_alert_at, :number, :null => false, :default => 0, :comment => "the minimum balance that the smb should maintain to avoid alerts"
  end
end
