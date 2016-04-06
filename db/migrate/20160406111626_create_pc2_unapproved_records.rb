class CreatePc2UnapprovedRecords < ActiveRecord::Migration
  def change
    create_table :pc2_unapproved_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :pc2_approvable_id
      t.string :pc2_approvable_type
      t.timestamps null: false
    end
  end
end
