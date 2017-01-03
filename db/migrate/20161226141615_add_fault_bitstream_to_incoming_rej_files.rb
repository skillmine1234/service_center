class AddFaultBitstreamToIncomingRejFiles < ActiveRecord::Migration
  def change
    add_column :incoming_rej_files, :fault_bitstream, :string, :comment => 'the complete exception list/stack trace of an exception that occured in the ESB'	
  end
end
