class CreateInwGuidelines < ActiveRecord::Migration[7.0]
  def change
    create_table :inw_guidelines do |t|# do #, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :code, limit: 5, null: false, comment: 'the identifier for the guideline'
      t.string :allow_neft, limit: 1, null: false, default: 'Y', comment: 'the indicator to specify if the guideline allows neft'
      t.string :allow_imps, limit: 1, null: false, default: 'Y', comment: 'the indicator to specify if the guideline allows imps'
      t.string :allow_rtgs, limit: 1, null: false, default: 'Y', comment: 'the indicator to specify if the guideline allows rtgs'
      t.integer :ytd_txn_cnt_bene, comment: 'the count of transactions allowed for a beneficiary in a calendar year'
      t.text :disallowed_products, comment: 'the list of product code which are disallowed for guideline'
      t.string :needs_lcy_rate, limit: 1, null: false, default: 'N', comment: 'the indicator to specify if lcy_rate is required for this guideline'
      t.string :is_enabled, limit: 1, null: false, default: 'Y', comment: 'the indicator to specify if the guideline is enabled or not'
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
      t.datetime :updated_at, :null => false, :comment => "the timestamp when the record was last updated"
      t.string :created_by, :limit => 20, :comment => "the person who creates the record"
      t.string :updated_by, :limit => 20, :comment => "the person who updates the record"
      t.integer :lock_version, :null => false, :default => 0, :comment => "the version number of the record, every update increments this by 1"
      t.string :approval_status, :limit => 1, :default => 'U', :null => false, :comment => "the indicator to denote whether this record is pending approval or is approved"
      t.string :last_action, :limit => 1, :default => 'C', :null => false, :comment => "the last action (create, update) that was performed on the record"
      t.integer :approved_version, :comment => "the version number of the record, at the time it was approved"
      t.integer :approved_id, :comment => "the id of the record that is being updated"
      t.index([:code, :approval_status], :unique => true, name: 'inw_guidelines_01')
    end
  end
end
