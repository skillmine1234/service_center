class AddTimedoutRecordCounterToIncomingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :timedout_record_count, :integer, :comment => "the count of timed out records"
  end
end