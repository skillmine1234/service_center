class CreateFpAuthRules < ActiveRecord::Migration
  def change
    create_table :fp_auth_rules do |t|
      t.string :username, :limit => 255, :null => false
      t.string :operation_name, :limit => 255, :null => false
      t.string :is_enabled, :limit => 1
      t.integer :lock_version, :null => false
      t.string :approval_status, :limit => 1, :null => false, :default => 'U'
      t.string :last_action, :limit => 1
      t.integer :approved_version
      t.integer :approved_id
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.timestamps null: false
    end
    add_index :fp_auth_rules, [:username, :operation_name], :unique => true
  end
end
