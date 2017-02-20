class CreateRrIncomingFiles < ActiveRecord::Migration
  def change
    create_table :rr_incoming_files,  {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
        t.string :file_name, :limit => 50, :comment => 'the name of the incoming_file'
        t.index([:file_name], :unique => true, :name => 'rr_incoming_files_01')     
    end
  end
end
