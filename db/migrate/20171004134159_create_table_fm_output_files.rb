class CreateTableFmOutputFiles < ActiveRecord::Migration
  def change
    create_table :fm_output_files , {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :incoming_file_id, null: false, comment: 'the id of the incoming file'
      t.string :step_name, limit: 50, comment: 'the step name which specify the output file'
      t.string :status_code, limit: 50, comment: 'the status code of the output file'            
      t.string :file_name, limit: 100, comment: 'the  name of  the output file'
      t.string :file_path, :comment => 'the file path of the output file'
      t.datetime :started_at, :null => false, :comment => "the SYSDATE when the file creation started"
      t.datetime :ended_at, :comment => "the SYSDATE when the file creation finished"
      t.string :fault_code, :limit => 50, :comment => "the code that identifies the business failure reason/exception"
      t.string :fault_subcode, :limit => 50, :comment => "the code that identifies the business failure reason/exception"      
      t.string :fault_reason, :limit => 1000, :comment => "the english reason of the business failure reason/exception"
      t.text :fault_bitstream, :limit => 1000, :comment => "the full bitstream of the failure reason/exception"      
    end    
  end
end
