class CreatePc2Apps < ActiveRecord::Migration
  def change
    create_table :pc2_apps do |t|
      t.string :app_id, :limit => 50, :null => false, :comment =>  "the unique id assigned to a client app"
      t.string :customer_id, :null => false, :limit => 50, :comment => "the unique no of the customer"
      t.string :identity_user_id, :limit => 20, :comment => "the identity of the user"
      t.string :is_enabled, :limit => 1, :null => false, :comment =>  "the indicator to denote if the app is allowed access"
      t.integer :lock_version, :null => false
      t.string :approval_status, :limit => 1, :null => false, :default => 'U'
      t.string :last_action, :limit => 1
      t.integer :approved_version
      t.integer :approved_id
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.timestamps null: false
      t.index([:app_id, :approval_status], :unique => true)
    end
  end
end
