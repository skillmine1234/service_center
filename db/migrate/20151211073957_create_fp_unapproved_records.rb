class CreateFpUnapprovedRecords < ActiveRecord::Migration
  def change
    create_table :fp_unapproved_records do |t|
      t.integer :fp_approvable_id
      t.string :fp_approvable_type
      
      t.timestamps null: false
    end
  end
end
