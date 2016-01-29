class AddColumnsInIncomingFileTypes < ActiveRecord::Migration
  def change
    add_column :incoming_file_types, :msg_domain, :string, :limit => 255, :comment => "the message domain for this file"
    add_column :incoming_file_types, :msg_model, :string, :limit => 255, :comment => "the name of the message model, required if the msg_domain is DFDL"
    change_column :incoming_file_types, :sc_service_id, :integer, :null => false, :comment => "the id of the service to which this file type belongs to"
    change_column :incoming_file_types, :code, :string, :limit => 50, :null => false, :comment => "the code this file type"
    change_column :incoming_file_types, :name, :string, :limit => 50, :null => false, :comment => "the name of the file type"
  end
end
