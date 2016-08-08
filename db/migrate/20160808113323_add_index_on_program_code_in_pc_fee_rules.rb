class AddIndexOnProgramCodeInPcFeeRules < ActiveRecord::Migration
  def change
    add_index :pc_fee_rules, [:program_code, :txn_kind, :approval_status], :unique => true, :name => 'pc_fee_rules_01'
  end
end
