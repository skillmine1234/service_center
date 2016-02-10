class CreateCsvExports < ActiveRecord::Migration
  def change
    create_table :csv_exports, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :user_id
      t.string :state
      t.string :request_type
      t.string :path
      t.string :group
      t.datetime :executed_at
      t.timestamps null: false
    end
  end
end
