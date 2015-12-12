class CreateFpOperations < ActiveRecord::Migration
  def change
    create_table :fp_operations do |t|
      t.string :operation_name, :limit => 255, :null => false, :comment =>  "the operation name of the FLEXCUBE service"
      t.integer :lock_version, :null => false
      t.string :approval_status, :limit => 1, :null => false, :default => 'U'
      t.string :last_action, :limit => 1
      t.integer :approved_version
      t.integer :approved_id
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.timestamps null: false
      t.index([:operation_name, :approval_status], :unique => true)
    end
  end
end
