class AddFileNameToIcIncomingFileRecords < ActiveRecord::Migration
  def change
    add_column :ic_incoming_records, :file_name, :string, :null => false, :limit=> 50, :comment => "the name of the incoming_file"    
  end
end
