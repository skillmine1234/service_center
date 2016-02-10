class CreateFtUnapprovedRecords < ActiveRecord::Migration
  def change
    create_table :ft_unapproved_records, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :ft_approvable_id
      t.string :ft_approvable_type
      t.timestamps null: false
    end
  end
end
