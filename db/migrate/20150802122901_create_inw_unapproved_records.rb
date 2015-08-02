class CreateInwUnapprovedRecords < ActiveRecord::Migration
  def change
    create_table :inw_unapproved_records do |t|
      t.integer :inw_approvable_id
      t.string :inw_approvable_type

      t.timestamps null: false
    end
  end
end