class CreateImtUnapprovedRecords < ActiveRecord::Migration
  def change
    create_table :imt_unapproved_records do |t|
      t.integer :imt_approvable_id
      t.string :imt_approvable_type
      t.timestamps null: false
    end
  end
end
