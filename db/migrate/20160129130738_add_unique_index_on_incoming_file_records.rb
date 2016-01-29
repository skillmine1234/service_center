class AddUniqueIndexOnIncomingFileRecords < ActiveRecord::Migration
  def change
    add_index :incoming_file_records, [:incoming_file_id, :record_no], :unique => true, :name => "uk_inc_file_records"
  end
end
