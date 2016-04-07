class CreateIcUnapprovedRecords < ActiveRecord::Migration
  def up
    create_table :ic_unapproved_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :ic_approvable_id
      t.string :ic_approvable_type

      t.timestamps null: false
    end
  end

  def down
    drop_table :ic_unapproved_records
  end
end
