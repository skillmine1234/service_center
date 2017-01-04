class CreateRcApps < ActiveRecord::Migration
  def change
    create_table :rc_apps do |t|
      t.string :app_id, null: false, limit: 50, comment: 'the app_id for the rc_app'
      t.integer :udfs_cnt, comment: 'the count of udfs for this app'
      t.string :udf1, comment: 'the udf 1 for the app'
      t.string :udf2, comment: 'the udf 2 for the app'
      t.string :udf3, comment: 'the udf 3 for the app'
      t.string :udf4, comment: 'the udf 4 for the app'
      t.string :udf5, comment: 'the udf 5 for the app'
      t.datetime :created_at, null: false, comment: "the timestamp when the record was created"
      t.datetime :updated_at, null: false, comment: "the timestamp when the record was last updated"
      t.string :created_by, limit: 20, comment: "the person who creates the record"
      t.string :updated_by, limit: 20, comment: "the person who updates the record"
      t.integer :lock_version, null: false, default: 0, comment: "the version number of the record, every update increments this by 1"
      t.string :last_action, limit: 1, default: 'C', null: false, comment: "the last action (create, update) that was performed on the record"
      t.index(:app_id, unique: true)
    end
  end
end
