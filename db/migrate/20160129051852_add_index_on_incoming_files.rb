class AddIndexOnIncomingFiles < ActiveRecord::Migration
  def change
    add_index :incoming_files, [:file_name, :approval_status], :unique => true
  end
end
