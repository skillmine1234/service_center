class CreateEcolApps < ActiveRecord::Migration
  def change
    create_table :ecol_apps, {sequence_start_value: '1 cache 20 order increment by 1'} do |t|
      t.string :app_code, null: false, limit: 50, comment: 'the code for the ecol_app'
      t.string :notify_url, limit: 100, comment: 'the notify URL for the app'
      t.string :validate_url, limit: 100, comment: 'the validate URL for the app'
      t.string :http_username, limit: 50, comment: 'the http_username for the app'
      t.string :http_password, limit: 50, comment: 'the http_password for the app'
      t.integer :settings_cnt, comment: 'the count of settings for this app'
      t.string :setting1, comment: 'the setting 1 for the app'
      t.string :setting2, comment: 'the setting 2 for the app'
      t.string :setting3, comment: 'the setting 3 for the app'
      t.string :setting4, comment: 'the setting 4 for the app'
      t.string :setting5, comment: 'the setting 5 for the app'
      t.datetime :created_at, null: false, comment: "the timestamp when the record was created"
      t.datetime :updated_at, null: false, comment: "the timestamp when the record was last updated"
      t.string :created_by, limit: 20, comment: "the person who creates the record"
      t.string :updated_by, limit: 20, comment: "the person who updates the record"
      t.integer :lock_version, null: false, default: 0, comment: "the version number of the record, every update increments this by 1"
      t.string :last_action, limit: 1, default: 'C', null: false, comment: "the last action (create, update) that was performed on the record"
      t.string :approval_status, limit: 1, default: 'U', null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
      t.integer :approved_version, comment: "the version number of the record, at the time it was approved"
      t.integer :approved_id, comment: "the id of the record that is being updated"

      t.index([:app_code, :approval_status], unique: true, name: 'ecol_apps_01') 
    end
  end
end
