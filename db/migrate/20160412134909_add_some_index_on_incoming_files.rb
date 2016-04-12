class AddSomeIndexOnIncomingFiles < ActiveRecord::Migration
  def change
    add_index :incoming_files, :service_name
    add_index :incoming_files, :status
    add_index :incoming_files, :pending_approval
  end
end
