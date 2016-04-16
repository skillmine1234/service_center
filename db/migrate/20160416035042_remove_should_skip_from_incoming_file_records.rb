class RemoveShouldSkipFromIncomingFileRecords < ActiveRecord::Migration
  def change
    remove_column :incoming_file_records, :should_skip
  end
end
