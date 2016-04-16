class AddFaultBitstreamToIncomingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :fault_bitstream, :text, :comment => 'the complete exception list/stack trace of an exception that occured in the ESB'
  end
end