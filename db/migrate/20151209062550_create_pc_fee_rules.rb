class CreatePcFeeRules < ActiveRecord::Migration
  def change
    create_table :pc_fee_rules do |t|
      t.integer :pc_app_id
      t.string :app_id, :limit => 50, :null => false
      t.string :txn_kind, :limit => 3, :null => false
      t.integer :no_of_tiers
      t.decimal :tier1_from_amt, :precision => 2
      t.decimal :tier1_to_amt, :precision => 2
      t.string :tier1_method, :limit => 3
      t.decimal :tier1_fixed_amt, :precision => 2
      t.decimal :tier1_pct_value, :precision => 2
      t.decimal :tier1_min_sc_amt, :precision => 2
      t.decimal :tier1_max_sc_amt, :precision => 2
      t.decimal :tier2_from_amt, :precision => 2
      t.decimal :tier2_to_amt, :precision => 2
      t.string :tier2_method, :limit => 3
      t.decimal :tier2_fixed_amt, :precision => 2
      t.decimal :tier2_pct_value, :precision => 2
      t.decimal :tier2_min_sc_amt, :precision => 2
      t.decimal :tier2_max_sc_amt, :precision => 2
      t.decimal :tier3_from_amt, :precision => 2
      t.decimal :tier3_to_amt, :precision => 2
      t.string :tier3_method, :limit => 3
      t.decimal :tier3_fixed_amt, :precision => 2
      t.decimal :tier3_pct_value, :precision => 2
      t.decimal :tier3_min_sc_amt, :precision => 2
      t.decimal :tier3_max_sc_amt, :precision => 2
      t.integer :lock_version, :null => false
      t.string :approval_status, :limit => 1, :null => false, :default => 'U'
      t.string :last_action, :limit => 1
      t.integer :approved_version
      t.integer :approved_id
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.timestamps :null => false
    end
    add_index :pc_fee_rules, [:app_id, :txn_kind, :approval_status], :unique => true
  end
end
