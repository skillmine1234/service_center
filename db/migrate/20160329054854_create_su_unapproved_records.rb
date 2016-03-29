class CreateSuUnapprovedRecords < ActiveRecord::Migration
  def change
    create_table :su_unapproved_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :su_approvable_id,  :comment =>"the id of the approvable su table" 
      t.string :su_approvable_type,  :comment =>"the type of the approvable su table" 
      t.datetime :created_at,  :comment =>"the timestamp when the file was created"   
      t.datetime :updated_at,  :comment =>"the timestamp when the record was last updated"   
    end
  end
end
