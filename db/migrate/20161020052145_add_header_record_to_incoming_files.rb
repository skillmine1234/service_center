class AddHeaderRecordToIncomingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :header_record, :text, :null => true, :comment => 'the header record as a bitstream, populated when it is skipped'    
  end
end
