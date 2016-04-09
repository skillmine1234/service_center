class ChangeIndexInIcIncomingRecords < ActiveRecord::Migration
  def change
    remove_index(:ic_incoming_records, :name => "ic_record_index")
    add_index :ic_incoming_records, [:incoming_file_record_id,:file_name], :name => "ic_record_index", :unique => true
  end
end
