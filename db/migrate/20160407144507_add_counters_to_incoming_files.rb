class AddCountersToIncomingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :record_count, :integer, :comment => "the count of data records in the file"
    add_column :incoming_files, :skipped_record_count, :integer, :comment => "the count of skipped records"
    add_column :incoming_files, :completed_record_count, :integer, :comment => "the count of completed (successful) records"
  end
end
