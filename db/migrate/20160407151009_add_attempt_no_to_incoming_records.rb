class AddAttemptNoToIncomingRecords < ActiveRecord::Migration
  def change
    add_column :incoming_file_records, :attempt_no, :integer, :comment => "the no of times processing was attempted"
  end
end
