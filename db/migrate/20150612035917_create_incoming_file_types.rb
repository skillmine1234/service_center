class CreateIncomingFileTypes < ActiveRecord::Migration
  def change
    create_table :incoming_file_types, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :sc_service_id, :null => false
      t.string :code, :limit => 50, :null => false
      t.string :name, :limit => 50, :null => false
    end
    add_index :incoming_file_types, :sc_service_id, :unique => true
    add_index :incoming_file_types, :code, :unique => true
    add_index :incoming_file_types, :name, :unique => true
  end
end
