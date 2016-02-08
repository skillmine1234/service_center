class AddRepColumnsToIncomingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :rep_file_name, :string, :comment => "the name of the response file"
    add_column :incoming_files, :rep_file_path, :string, :comment => "the directory/path of the response file"
    add_column :incoming_files, :rep_file_status, :string, :comment => "the status of the creation/writing of the response file"

  end
end
