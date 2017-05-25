class AddColumnsToRcTransferScheduleTable < ActiveRecord::Migration
  def up
    add_column :rc_transfer_schedule, :ch_sweep_out, :number, :null => false, :default => 0, :comment => "the minimum account balance to be maintained during the transfer"    
    add_column :rc_transfer_schedule, :bene_account_ifsc, :string, :limit => 11, :null => false, :default => 'YESB0000001', :comment => "the beneficiary account IFSC"          
    add_column :rc_transfer_schedule, :max_retries, :integer, :null => false, :default => 0, :comment => "the retry count for schedule/instruction" 
    add_column :rc_transfer_schedule, :retry_in_mins, :integer, :null => false, :default => 0, :comment => "the schedule/instruction attempt number"         
  end

  def down
    remove_column :rc_transfer_schedule, :ch_sweep_out
    remove_column :rc_transfer_schedule, :bene_account_ifsc
    remove_column :rc_transfer_schedule, :max_retries
    remove_column :rc_transfer_schedule, :retry_in_mins
  end
end
