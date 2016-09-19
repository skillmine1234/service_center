class RenamePcIncomingRecordsToPcMmCrDrIncomingRecords < ActiveRecord::Migration
  def change
    rename_table :pc_incoming_files, :pc_mm_cd_incoming_files
    rename_table :pc_incoming_records, :pc_mm_cd_incoming_records
  end
end
