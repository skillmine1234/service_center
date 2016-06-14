class AddPendingRetryRecordCountToIncommingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :pending_retry_record_count, :integer, :comment => "the count of records with status pending retry"
  end
end
