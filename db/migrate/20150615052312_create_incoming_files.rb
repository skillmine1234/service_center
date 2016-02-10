class CreateIncomingFiles < ActiveRecord::Migration
  def change
    create_table :incoming_files, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :service_name, :limit => 10
      t.string :file_type, :limit => 10
      t.string :file
      t.string :file_name, :limit => 50
      t.integer :size_in_bytes
      t.integer :line_count
      t.string :status, :limit => 1
      t.date :started_at
      t.date :ended_at
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      
      t.timestamps null: false
    end
  end
end
