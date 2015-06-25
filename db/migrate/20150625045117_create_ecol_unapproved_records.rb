class CreateEcolUnapprovedRecords < ActiveRecord::Migration
  def change
    create_table :ecol_unapproved_records do |t|
      t.integer :ecol_approvable_id
      t.string :ecol_approvable_type

      t.timestamps null: false
    end
  end
end
