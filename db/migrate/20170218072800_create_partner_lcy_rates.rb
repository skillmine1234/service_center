class CreatePartnerLcyRates < ActiveRecord::Migration
  def change
    create_table :partner_lcy_rates do |t|
      t.string :partner_code, limit: 20, null: false, comment: 'the code of the partner' 
      t.number :rate, comment: 'the lcy rate for the partner'
      t.string :is_enabled, limit: 1, null: false, default: 'Y', comment: 'the indicator to specify if the guideline is enabled or not'
      t.datetime :created_at, null: false, comment: "the timestamp when the record was created"
      t.datetime :updated_at, null: false, comment: "the timestamp when the record was last updated"
      t.string :created_by, limit: 20, comment:  "the person who creates the record"
      t.string :updated_by, limit: 20, comment: "the person who updates the record"
      t.integer :lock_version, null: false, default: 0, comment: "the version number of the record, every update increments this by 1"
      t.string :approval_status, limit: 1, default: 'U', null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
      t.string :last_action, limit: 1, default: 'C', null: false, comment: "the last action (create, update) that was performed on the record"
      t.integer :approved_version, comment: "the version number of the record, at the time it was approved"
      t.integer :approved_id, comment: "the id of the record that is being updated"
      t.index([:partner_code, :approval_status], unique: true, name: 'partner_lcy_rates_01')
    end
  end
end
