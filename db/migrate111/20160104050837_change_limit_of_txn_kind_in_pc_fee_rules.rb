class ChangeLimitOfTxnKindInPcFeeRules < ActiveRecord::Migration[7.0]
  def change
    change_column :pc_fee_rules, :txn_kind, :string, :limit => 50, :null => false, :comment =>  "the transaction for which the fee rules are configured"
  end
end
