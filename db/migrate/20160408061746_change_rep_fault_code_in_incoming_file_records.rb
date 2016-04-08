class ChangeRepFaultCodeInIncomingFileRecords < ActiveRecord::Migration
  def change
    add_column :incoming_file_records, :rep_fault_code1, :string, :limit => 50, :comment => "the code of the fault that was generated while creating/writing the response record"
    IncomingFileRecord.find_each(batch_size: 100) do |incoming_file_record|
      incoming_file_record.rep_fault_code1 = incoming_file_record.rep_fault_code
      incoming_file_record.save
    end
    remove_column :incoming_file_records, :rep_fault_code
    rename_column :incoming_file_records, :rep_fault_code1, :rep_fault_code
  end
end