class CreateBmUnapprovedRecords < ActiveRecord::Migration
  def change
    create_table :bm_unapproved_records do |t|
      t.integer :bm_approvable_id
      t.string :bm_approvable_type

      t.timestamps null: false
    end
  end
end
