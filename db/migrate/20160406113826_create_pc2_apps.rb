class CreatePc2Apps < ActiveRecord::Migration
  def change
    create_table :pc2_apps, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :app_id, :limit => 50, :null => false, :comment =>  "the unique id assigned to a client app"
      t.string :customer_id, :null => false, :limit => 50, :comment => "the unique no of the customer"
      t.string :identity_user_id, :limit => 20, :null => false, :comment => "the identity of the user"
      t.string :is_enabled, :limit => 1, :null => false, :comment =>  "the indicator to denote if the app is allowed access"
      t.integer :lock_version,  :default => 0, :comment =>"the version number of the record every update increments this by 1"
      t.string :approval_status, :limit => 1, :default => 'U', :comment =>"the indicator to denote whether this record is pending approval or is approved" 
      t.string :last_action, :limit => 1, :default => 'C', :comment =>"the last action create or update that was performed on the record"   
      t.integer :approved_version,  :comment =>"the version number of the record at the time it was approved"
      t.integer :approved_id,  :comment =>"the id of the record that is being updated"
      t.string :created_by, :limit => 20, :comment =>"the person who creates the record"   
      t.string :updated_by, :limit => 20, :comment =>"the person who updates the record"  
      t.datetime :created_at,  :comment =>"the timestamp when the file was created"   
      t.datetime :updated_at,  :comment =>"the timestamp when the record was last updated"   
      t.index([:app_id, :approval_status], :unique => true)
    end
  end
end
