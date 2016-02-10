class CreateInwUnapprovedRecords < ActiveRecord::Migration
  def change
    create_table :inw_unapproved_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :inw_approvable_id
      t.string :inw_approvable_type

      t.timestamps null: false
    end
  end
end