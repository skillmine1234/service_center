class CreateOutgoingFileType < ActiveRecord::Migration
  def change
    create_table  :outgoing_file_types, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer  :sc_service_id, :null => false, :comment => "the id of the service to which this file type belongs to"
      t.string  :code, :limit => 50, :null => false, :comment => "the code this file type"
      t.string  :name, :limit => 50, :null => false, :comment => "the name of the file type"
      
      t.string  :db_unit_name, :limit => 255, :comment => "the name of the database unit (package or procedure) that returns the result set"
      t.string  :msg_domain, :limit => 255, :comment => "the message domain for this file"
      t.string  :msg_model, :limit => 255, :comment => "the name of the message model, required if the msg_domain is DFDL"
      t.string  :row_name, :limit => 255, :comment => "the name of the element that represents the row (repeating element) in the result set"
      t.string  :file_name, :limit => 255, :comment => "the name of the output file, to be specified without the extension"      

      t.index [:code, :sc_service_id], :unique => true
    end
  end
end
