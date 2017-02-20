class CreateRrUnapprovedRecords < ActiveRecord::Migration
  def up
    create_table :rr_unapproved_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :rr_approvable_id,  :comment =>"the id of the approvable sm table" 
      t.string :rr_approvable_type,  :comment =>"the type of the approvable sms table" 
      t.datetime :created_at,  :comment =>"the timestamp when the file was created"   
      t.datetime :updated_at,  :comment =>"the timestamp when the record was last updated" 
    end
  end

  def down
    drop_table :rr_unapproved_records
  end
end
