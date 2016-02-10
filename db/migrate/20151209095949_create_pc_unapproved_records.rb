class CreatePcUnapprovedRecords < ActiveRecord::Migration
  def change
    create_table :pc_unapproved_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :pc_approvable_id
      t.string :pc_approvable_type
      t.timestamps null: false
    end
  end
end
