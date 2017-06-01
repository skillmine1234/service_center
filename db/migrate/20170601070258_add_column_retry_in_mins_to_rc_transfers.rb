class AddColumnRetryInMinsToRcTransfers < ActiveRecord::Migration
  def change
    add_column :rc_transfers, :retry_in_mins, :integer, :comment => "the retry interval for the instruction/schedule"      
  end
end
