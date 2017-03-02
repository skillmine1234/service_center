class Cnb2IncomingFiles < ActiveRecord::Migration
  def change
    create_table :cnb2_incoming_files, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string  :file_name, :limit => 100, :comment => "the name of the incoming_file"    
      t.string  :account, :limit => 20,  :comment => "the account number of the incoming_file"  
      t.string  :cnb_file_name, :limit => 100,  :comment => "the name of the cnb response file"  
      t.string  :cnb_file_path, :limit => 255,  :comment => "the path of the cnb response file"
      t.string  :cnb_file_status, :limit => 50,  :comment => "the status of the response file"       
      t.index([:file_name], :unique => true, :name => 'cnb2_incoming_files_01')    
    end
  end
end
