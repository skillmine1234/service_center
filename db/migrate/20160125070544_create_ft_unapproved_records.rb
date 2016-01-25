class CreateFtUnapprovedRecords < ActiveRecord::Migration
  def change
    create_table :ft_unapproved_records do |t|
      t.integer :ft_approvable_id
      t.string :ft_approvable_type
      t.timestamps null: false
    end
  end
end
