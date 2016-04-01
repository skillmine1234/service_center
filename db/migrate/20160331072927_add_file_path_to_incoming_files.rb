class AddFilePathToIncomingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :file_path, :string, :comment => 'represents the path of incoming file'
  end
end
