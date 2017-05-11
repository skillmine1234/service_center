class AddColumnsSlNoAndCreatedDateToIc001IncomingRecords < ActiveRecord::Migration
  def change
    add_column :ic001_incoming_records, :sl_no, :number, :comment => "the serial number of the reocrds in incoming file"
    add_column :ic001_incoming_records, :created_date, :date, :comment => "the created date of the record"
  end
end
