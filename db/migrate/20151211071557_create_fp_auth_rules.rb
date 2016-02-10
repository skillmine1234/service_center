class CreateFpAuthRules < ActiveRecord::Migration
  def change
    create_table :fp_auth_rules, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :username, :limit => 255, :null => false, :comment =>  "the identity that is allowed access to the operation"
      t.string :operation_name, :limit => 255, :null => false, :comment =>  "the operation to which access is granted"
      t.string :is_enabled, :limit => 1, :comment =>  "the indicator to denote whether the access is enabled"
      t.integer :lock_version, :null => false
      t.string :approval_status, :limit => 1, :null => false, :default => 'U'
      t.string :last_action, :limit => 1
      t.integer :approved_version
      t.integer :approved_id
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.timestamps null: false
      t.index([:username, :operation_name, :approval_status], :unique => true, :name => 'uk_fp_auth_rules')
    end    
  end
end
