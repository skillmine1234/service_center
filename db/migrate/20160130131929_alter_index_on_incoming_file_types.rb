class AlterIndexOnIncomingFileTypes < ActiveRecord::Migration
  def change
    remove_index :incoming_file_types, :name => "I_INC_FIL_TYP_SC_SER_ID"
    remove_index :incoming_file_types, :name => "I_INCOMING_FILE_TYPES_NAME"
    remove_index :incoming_file_types, :name => "I_INCOMING_FILE_TYPES_CODE"
    add_index :incoming_file_types, [:sc_service_id, :code], :unique => true, :name => 'UK_IN_FILE_TYPES_1'
  end
end
