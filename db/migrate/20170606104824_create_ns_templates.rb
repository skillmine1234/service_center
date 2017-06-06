class CreateNsTemplates < ActiveRecord::Migration
  def change
    create_table :ns_templates , {sequence_start_value: '1 cache 20 order increment by 1'} do |t|
      t.integer :sc_event_id, null: false, comment: 'the id of the sc event record'
      t.text :sms_template, comment: 'the template for the SMS'
      t.text :email_template, comment: 'the template for the email'
      t.string :is_enabled, limit: 1, default: 'Y', null: false, comment: 'the flag to indicate whether the template is enabled or not'
      t.datetime :created_at, null: false, comment: "the timestamp when the record was created"
      t.datetime :updated_at, null: false, comment: "the timestamp when the record was last updated"
      t.string :created_by, limit: 20, comment: "the person who creates the record"
      t.string :updated_by, limit: 20, comment: "the person who updates the record"
      t.integer :lock_version, null: false, default: 0, comment: "the version number of the record, every update increments this by 1"
      t.string :last_action, limit: 1, default: 'C', null: false, comment: "the last action (create, update) that was performed on the record"
      t.string :approval_status, limit: 1, default: 'U', null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
      t.integer :approved_version, comment: "the version number of the record, at the time it was approved"
      t.integer :approved_id, comment: "the id of the record that is being updated"

      t.index([:sc_event_id, :approval_status], unique: true, name: 'ns_templates_01')
    end
  end
end
