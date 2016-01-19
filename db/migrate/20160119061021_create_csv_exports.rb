class CreateCsvExports < ActiveRecord::Migration
  def change
    create_table :csv_exports do |t|
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
