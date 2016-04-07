class ChangeRepFileStatusInIncomingFiles < ActiveRecord::Migration
  def change
    change_column :incoming_files, :rep_file_status, :string, :limit => 1, :comment => "the status of the creation/writing of the response file"
  end
end
