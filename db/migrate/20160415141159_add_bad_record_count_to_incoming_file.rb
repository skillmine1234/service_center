class AddBadRecordCountToIncomingFile < ActiveRecord::Migration
  def change
    add_column :incoming_files, :bad_record_count, :int, :comment => "the count of bad (unparsed) records"
  end
end
