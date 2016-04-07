class CreatePc2UnapprovedRecords < ActiveRecord::Migration
  def change
    create_table :pc2_unapproved_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :pc2_approvable_id, :comment =>"the id of the approvable pc2 table" 
      t.string :pc2_approvable_type, :comment =>"the type of the approvable pc2 table" 
      t.datetime :created_at,  :comment =>"the timestamp when this record was created"   
      t.datetime :updated_at,  :comment =>"the timestamp when this record was last updated"  
    end
  end
end
