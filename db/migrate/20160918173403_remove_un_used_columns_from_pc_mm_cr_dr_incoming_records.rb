class RemoveUnUsedColumnsFromPcMmCrDrIncomingRecords < ActiveRecord::Migration
  def up
    remove_column :pc_mm_cd_incoming_records, :status_code
    remove_column :pc_mm_cd_incoming_records, :fault_code
    remove_column :pc_mm_cd_incoming_records, :fault_subcode
    remove_column :pc_mm_cd_incoming_records, :fault_reason
  end
  def down
    add_column :pc_mm_cd_incoming_records, :status_code, :string, :limit => 10, :comment => "the status of the record"
    add_column :pc_mm_cd_incoming_records, :fault_code, :string, :limit => 50, :comment => "the code that identifies the exception, if an exception occured in the ESB"
    add_column :pc_mm_cd_incoming_records, :fault_subcode, :string, :limit => 50, :comment => "the error code that the third party will return"
    add_column :pc_mm_cd_incoming_records, :fault_reason, :string, :limit => 1000, :comment => "the english reason of the exception, if an exception occurred in the ESB"
  end
end
