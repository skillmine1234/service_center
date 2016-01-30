class AlterIndexOnIncomingFileTypes < ActiveRecord::Migration
  def change
    remove_index :incoming_file_types, :sc_service_id
    remove_index :incoming_file_types, :name
    remove_index :incoming_file_types, :code
    add_index :incoming_file_types, [:sc_service_id, :code], :unique => true, :name => 'UK_IN_FILE_TYPES_1'
  end
end
