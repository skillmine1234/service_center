class RenameColumnChSweepOutToAcctThresholdAmt < ActiveRecord::Migration
  def change
    rename_column :rc_transfer_schedule, :ch_sweep_out, :acct_threshold_amt 
    rename_column :rc_transfers, :ch_sweep_out, :acct_threshold_amt    
  end
end