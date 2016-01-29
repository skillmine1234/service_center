class AddColumnsToIncomingFileRecords < ActiveRecord::Migration
  def change
    change_column :incoming_file_records, :incoming_file_id, :integer, :comment => "the id of the incoming file to which this record belongs to"
    change_column :incoming_file_records, :record_no, :integer, :comment => "the number of the record in the file, starts from 1"
    change_column :incoming_file_records, :status, :string, :limit => 20, :comment => "the current status of the record"
    change_column :incoming_file_records, :status, :string, :limit => 20, :comment => "the current status of the record"
    change_column :incoming_file_records, :fault_code, :string, :limit => 50, :comment => "the code that identifies the business failure reason/exception"
    change_column :incoming_file_records, :fault_reason, :string, :limit => 500, :comment => "the english reason of the business failure reason/exception"
    add_column :incoming_file_records, :fault_subcode, :string, :limit => 50, :comment => "the error code that the third party will return"
    add_column :incoming_file_records, :fault_bitstream, :text, :comment => "the exception list that was generated if the record failed to parse/validate as per the model defined"
  end
end
