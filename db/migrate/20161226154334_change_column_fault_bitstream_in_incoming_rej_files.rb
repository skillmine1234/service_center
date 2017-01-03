class ChangeColumnFaultBitstreamInIncomingRejFiles < ActiveRecord::Migration
  def change
    remove_column :incoming_rej_files, :fault_bitstream
    add_column :incoming_rej_files, :fault_bitstream, :text, :comment => 'the complete exception list/stack trace of an exception that occured in the ESB'
  end
end
