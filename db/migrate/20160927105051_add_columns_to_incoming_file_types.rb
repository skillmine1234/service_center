class AddColumnsToIncomingFileTypes < ActiveRecord::Migration
  def up
    add_column :incoming_file_types, :can_override, :string, :limit => 1, default: "N", :null => false, :comment => 'the flag to indicate whether the incoming file can be overriden'
    add_column :incoming_file_types, :can_skip, :string, :limit => 1, default: "N", :null => false, :comment => 'the flag to indicate whether the incoming file can be skipped'
    add_column :incoming_file_types, :can_retry, :string, :limit => 1, default: "N", :null => false, :comment => 'the flag to indicate whether the incoming file can be retried'
    add_column :incoming_file_types, :build_nack_file, :string, :limit => 1, default: "N", :null => false, :comment => 'the flag to indicate whether the nack file can be generated'
    add_column :incoming_files, :nack_file_name, :string, :comment => "the name of the nack file"
    add_column :incoming_files, :nack_file_path, :string, :comment => "the directory/path of the nack file"
    add_column :incoming_files, :nack_file_status, :string, :limit => 1, :comment => "the status of the creation/writing of the nack file"
  end

  def down
    remove_column :incoming_file_types, :can_override
    remove_column :incoming_file_types, :can_skip
    remove_column :incoming_file_types, :can_retry
    remove_column :incoming_file_types, :build_nack_file
    remove_column :incoming_files, :nack_file_name
    remove_column :incoming_files, :nack_file_path
    remove_column :incoming_files, :nack_file_status
  end
end
