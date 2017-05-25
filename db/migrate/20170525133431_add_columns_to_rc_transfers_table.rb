class AddColumnsToRcTransfersTable < ActiveRecord::Migration
  def up
    add_column :rc_transfers, :ch_sweep_out, :number, :comment => "the minimum account balance to be maintained during the transfer"   
    add_column :rc_transfers, :transfer_type, :string, :comment => "the transfer type choosen for transfer"     
    add_column :rc_transfers, :available_balance, :number, :comment => "the available account balance"       
    add_column :rc_transfers, :max_retries, :integer, :null => false, :default => 0, :comment => "the max retry count for the instruction/schedule" 
    add_column :rc_transfers, :attempt_no, :integer, :null => false, :default => 1, :comment => "the attempt number for the instruction/schedule"         
  end

  def down
    remove_column :rc_transfers, :ch_sweep_out
    remove_column :rc_transfers, :transfer_type
    remove_column :rc_transfers, :available_balance
    remove_column :rc_transfers, :max_retries
    remove_column :rc_transfers, :attempt_no    
  end
end
