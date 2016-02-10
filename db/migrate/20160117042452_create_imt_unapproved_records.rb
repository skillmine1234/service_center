class CreateImtUnapprovedRecords < ActiveRecord::Migration
  def change
    create_table :imt_unapproved_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :imt_approvable_id
      t.string :imt_approvable_type
      t.timestamps null: false
    end
  end
end
