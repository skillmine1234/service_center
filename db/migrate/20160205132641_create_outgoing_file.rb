class CreateOutgoingFile < ActiveRecord::Migration
  def change
    create_table :outgoing_files, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string   :service_code, :null => false, :comment => "the code of the service to which this file type belongs to"
      t.string   :file_type, :null => false, :comment => "the type of the file basis upon the data that it contains"
      t.string   :file_name, :limit => 50, :null => false, :comment => "the name of the output file"
      t.string   :file_path, :limit => 50, :null => false, :comment => "the path where the file was written"
      t.integer  :line_count, :limit => 38, :null => false, :comment => "the number of lines written to the file"
      t.datetime :started_at,  :null => false, :comment => "the start date of the file extract"
      t.datetime :ended_at, :null => true, :comment => "the end date of the file extract"
      t.string   :email_ref, :comment => "the reference no to check the status of the email, from SendEmail.app"
    end
  end
end


