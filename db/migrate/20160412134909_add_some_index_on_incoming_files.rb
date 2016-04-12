class AddSomeIndexOnIncomingFiles < ActiveRecord::Migration
  def change
    add_index :incoming_files, [:service_name, :status, :pending_approval], :name => "index_on_service"
  end
end
