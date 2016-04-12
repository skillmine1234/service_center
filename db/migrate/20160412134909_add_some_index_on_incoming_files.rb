class AddSomeIndexOnIncomingFiles < ActiveRecord::Migration
  def change
    add_index :incoming_files, [:service_name, :status, :pending_approval], :name => "in_incoming_files_2"
  end
end
