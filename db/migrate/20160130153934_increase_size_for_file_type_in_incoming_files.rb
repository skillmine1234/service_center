class IncreaseSizeForFileTypeInIncomingFiles < ActiveRecord::Migration
  def change
    change_column :incoming_files, :service_name, :string, :comment => "the name of the service to which this file belongs to"
    change_column :incoming_files, :file_type, :string, :comment => "the type of the file basis upon the data that it contains"
  end
end
