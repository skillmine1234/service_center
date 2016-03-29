class AddSkipAndOverrideColumnsToIncomingFileRecords < ActiveRecord::Migration
  def change
    add_column :incoming_file_records, :should_skip, :string, :limit => 1, :comment => "the indicator that tells whether the record is skipped"
    add_column :incoming_file_records, :overrides, :string, :limit => 50, :comment => "the indicator that tells whether the record is overriden"
  end
end
