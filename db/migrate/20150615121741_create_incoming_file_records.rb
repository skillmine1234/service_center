class CreateIncomingFileRecords < ActiveRecord::Migration
  def change
    create_table :incoming_file_records do |t|
      t.integer :incoming_file_id
      t.integer :record_no
      t.text :record_txt
      t.string :status, :limit => 20
      t.string :fault_code, :limit => 50
      t.string :fault_reason, :limit => 500

      t.timestamps null: false
    end
  end
end
