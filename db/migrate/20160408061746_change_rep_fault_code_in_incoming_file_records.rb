class ChangeRepFaultCodeInIncomingFileRecords < ActiveRecord::Migration
  def change
    change_column :incoming_file_records, :rep_fault_code, :string, :limit => 50, :comment => "the code of the fault that was generated while creating/writing the response record"
  end
end
