class CreateTableFrR01IncomingFiles < ActiveRecord::Migration
  def change
    create_table :fr_r01_incoming_files, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string  :file_name, :limit => 100, :comment => "the name of the incoming_file"    
      t.index([:file_name], :unique => true, :name => 'fr_r01_incoming_files_01')    				
    end
  end
end
