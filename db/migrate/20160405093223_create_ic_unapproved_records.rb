class CreateIcUnapprovedRecords < ActiveRecord::Migration
  def up
    create_table :ic_unapproved_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :ic_approvable_id,  :comment =>"the id of the approvable ic table" 
      t.string :ic_approvable_type,  :comment =>"the type of the approvable ic table" 
      t.datetime :created_at,  :comment =>"the timestamp when the file was created"   
      t.datetime :updated_at,  :comment =>"the timestamp when the record was last updated" 
    end
  end

  def down
    drop_table :ic_unapproved_records
  end
end
