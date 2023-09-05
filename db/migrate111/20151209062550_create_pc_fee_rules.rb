class CreatePcFeeRules < ActiveRecord::Migration[7.0]
  def change
    create_table :pc_fee_rules do |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :app_id, :limit => 50, :null => false, :comment =>  "the unique id assigned to the client app"
      t.string :txn_kind, :limit => 3, :null => false, :comment =>  "the transaction for which the fee rules are configured"
      t.integer :no_of_tiers, :null => false, :comment =>  "the no of tiers (max 3)"
      t.integer :tier1_to_amt, :null => false, :comment =>  "the to amount (exclusive) for tier 1"
      t.string :tier1_method, :null => false, :limit => 3, :comment =>  "the fee computation method (Fixed/Percentage) for tier 1"
      t.integer :tier1_fixed_amt, :null => false, :comment =>  "the fixed fee amount for tier 1"
      t.integer :tier1_pct_value, :null => false, :comment =>  "the pct value for tier 1"
      t.integer :tier1_min_sc_amt, :null => false, :comment =>  "the min fee amount, when pct is applied for tier 1"
      t.integer :tier1_max_sc_amt, :null => false, :comment =>  "the max fee amount, when pct is applied for tier 1"
      t.integer :tier2_to_amt, :comment =>  "the to amount (exclusive) for tier 2"
      t.string :tier2_method, :limit => 3, :comment =>  "the fee computation method (Fixed/Percentage) for tier 2"
      t.integer :tier2_fixed_amt, :comment =>  "the fixed fee amount for tier 2"
      t.integer :tier2_pct_value, :comment =>  "the pct value for tier 2"
      t.integer :tier2_min_sc_amt, :comment =>  "the min fee amount, when pct is applied for tier 2"
      t.integer :tier2_max_sc_amt, :comment =>  "the max fee amount, when pct is applied for tier 2"
      t.string :tier3_method, :limit => 3, :comment =>  "the fee computation method (Fixed/Percentage) for tier 3"
      t.integer :tier3_fixed_amt, :comment =>  "the fixed fee amount for tier 3"
      t.integer :tier3_pct_value, :comment =>  "the pct value for tier 3"
      t.integer :tier3_min_sc_amt, :comment =>  "the min fee amount, when pct is applied for tier 3"
      t.integer :tier3_max_sc_amt, :comment =>  "the max fee amount, when pct is applied for tier 3"
      t.integer :lock_version, :null => false
      t.string :approval_status, :limit => 1, :null => false, :default => 'U'
      t.string :last_action, :limit => 1
      t.integer :approved_version
      t.integer :approved_id
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.timestamps :null => false
      t.index([:app_id, :txn_kind, :approval_status], :unique => true, :name => 'uk_pc_fee_rules')
    end    
  end
end
