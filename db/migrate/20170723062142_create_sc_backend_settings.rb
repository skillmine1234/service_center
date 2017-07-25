class CreateScBackendSettings < ActiveRecord::Migration
  def change
    create_table :sc_backend_settings, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :backend_code, null: false, limit: 50, comment: 'the backend code for the setting'
      t.string :service_code, null: false, limit: 50, comment: 'the service code for the setting'
      t.string :app_id, limit: 50, comment: 'the app_id for the setting'
      t.integer :settings_cnt, comment: 'the count of settings for this setting'
      t.string :setting1, comment: 'the setting 1 for the setting'
      t.string :setting2, comment: 'the setting 2 for the setting'
      t.string :setting3, comment: 'the setting 3 for the setting'
      t.string :setting4, comment: 'the setting 4 for the setting'
      t.string :setting5, comment: 'the setting 5 for the setting'
      t.string :setting6, comment: 'the setting 6 for the setting'
      t.string :setting7, comment: 'the setting 7 for the setting'
      t.string :setting8, comment: 'the setting 8 for the setting'
      t.string :setting9, comment: 'the setting 9 for the setting'
      t.string :setting10, comment: 'the setting 10 for the setting'
      t.datetime :created_at, null: false, comment: "the timestamp when the record was created"
      t.datetime :updated_at, null: false, comment: "the timestamp when the record was last updated"
      t.string :created_by, limit: 20, comment: "the person who creates the record"
      t.string :updated_by, limit: 20, comment: "the person who updates the record"
      t.integer :lock_version, null: false, default: 0, comment: "the version number of the record, every update increments this by 1"
      t.string :last_action, limit: 1, default: 'C', null: false, comment: "the last action (create, update) that was performed on the record"
      t.string :approval_status, limit: 1, default: 'U', null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
      t.integer :approved_version, comment: "the version number of the record, at the time it was approved"
      t.integer :approved_id, comment: "the id of the record that is being updated"

      t.index([:backend_code, :service_code, :app_id, :approval_status], unique: true, name: 'sc_backend_settings_01') 
    end
  end
end
