class CreateNsCallbacks < ActiveRecord::Migration
  def change
    create_table :ns_callbacks , {sequence_start_value: '1 cache 20 order increment by 1'} do |t|
      t.string :app_code, null: false, limit: 50, comment: 'the code for the ns_callback'
      t.string :notify_url, limit: 100, comment: 'the notify URL for the app'
      t.string :http_username, limit: 50, comment: 'the http_username for the ns_callback'
      t.string :http_password, limit: 50, comment: 'the http_password for the ns_callback'
      t.integer :settings_cnt, comment: 'the count of settings for this ns_callback'
      t.string :setting1, comment: 'the setting 1 for the ns_callback'
      t.string :setting2, comment: 'the setting 2 for the ns_callback'
      t.string :setting3, comment: 'the setting 3 for the ns_callback'
      t.string :setting4, comment: 'the setting 4 for the ns_callback'
      t.string :setting5, comment: 'the setting 5 for the ns_callback'
      t.integer :udfs_cnt, default: 0, comment: 'the count of udfs for this ns_callback'
      t.integer :unique_udfs_cnt, default: 0, comment: 'the count of unique indexes on udfs for this ns_callback'
      t.string :udf1, :string, comment: 'the udf1 for this ns_callback'
      t.string :udf2, :string, comment: 'the udf2 for this ns_callback'
      t.string :udf3, :string, comment: 'the udf3 for this ns_callback'
      t.string :udf4, :string, comment: 'the udf4 for this ns_callback'
      t.string :udf5, :string, comment: 'the udf5 for this ns_callback'
      t.datetime :created_at, null: false, comment: "the timestamp when the record was created"
      t.datetime :updated_at, null: false, comment: "the timestamp when the record was last updated"
      t.string :created_by, limit: 20, comment: "the person who creates the record"
      t.string :updated_by, limit: 20, comment: "the person who updates the record"
      t.integer :lock_version, null: false, default: 0, comment: "the version number of the record, every update increments this by 1"
      t.string :last_action, limit: 1, default: 'C', null: false, comment: "the last action (create, update) that was performed on the record"
      t.string :approval_status, limit: 1, default: 'U', null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
      t.integer :approved_version, comment: "the version number of the record, at the time it was approved"
      t.integer :approved_id, comment: "the id of the record that is being updated"

      t.index([:app_code, :approval_status], unique: true, name: 'ns_callbacks_01')
    end
  end
end
