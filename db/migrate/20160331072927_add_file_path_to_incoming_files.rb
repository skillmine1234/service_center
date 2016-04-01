class AddFilePathToIncomingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :file_path, :string, :comment => 'the path of the incoming file'
  end
end
