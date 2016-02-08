class AddRepColumnsToIncomingFileRecords < ActiveRecord::Migration
  def change
    add_column :incoming_file_records, :rep_status, :string, :limit => 50, :comment => "the status of the creation/writing of the response record"
    add_column :incoming_file_records, :rep_fault_code, :text, :comment => "the code of the fault that was generated while creating/writing the response record"
    add_column :incoming_file_records, :rep_fault_subcode, :string, :limit => 50, :comment => "the internal code of the fault that was generated while creating/writing the response record"
    add_column :incoming_file_records, :rep_fault_reason, :string, :limit => 500, :comment => "the english text for the rep_fault_code"
    add_column :incoming_file_records, :rep_fault_bitstream, :text, :comment => "the exception list that was generated while creating/writing the response record"

  end
end
