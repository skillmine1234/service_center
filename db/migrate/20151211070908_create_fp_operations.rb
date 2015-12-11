class CreateFpOperations < ActiveRecord::Migration
  def change
    create_table :fp_operations do |t|
      t.string :operation_name, :limit => 255, :null => false
      t.integer :lock_version, :null => false
      t.string :approval_status, :limit => 1, :null => false, :default => 'U'
      t.string :last_action, :limit => 1
      t.integer :approved_version
      t.integer :approved_id
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.timestamps null: false
    end
    add_index :fp_operations, :operation_name, :unique => true
  end
end
