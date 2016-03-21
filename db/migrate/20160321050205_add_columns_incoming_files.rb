class AddColumnsIncomingFiles < ActiveRecord::Migration
  def change
        add_column :incoming_files, :pending_approval, :string
        add_column :incoming_files, :abort_when_failed, :string
        add_column :incoming_files, :process_next_record, :string
  end
end
