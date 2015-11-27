class AddColumnsToBmAggregatorPayments < ActiveRecord::Migration
  def change
    add_column :bm_aggregator_payments, :pending_approval, :string, :limit => 1, :null => false, :default => 'Y', :comment => "the indicator that denotes whether a human approval is awaited (Y) or not (N)"
    add_column :bm_aggregator_payments, :bene_acct_ifsc, :string, :limit => 255, :null => false, :default => '1', :comment => "the IFSC code of the bank that holds the aggregators account"
    add_column :bm_aggregator_payments, :rmtr_to_bene_note, :string, :limit => 255, :comment => "the narrative for transaction of remitter to beneficiary"
    add_column :bm_aggregator_payments, :is_reconciled, :string, :limit => 1, :null => false, :default => 'Y', :comment => "the indicator that denotes whether the transaction was reconciled (Y)"
    add_column :bm_aggregator_payments, :reconciled_at, :date, :comment => "the SYSDATE when the transaction was reconciled"
    add_column :bm_aggregator_payments, :neft_attempt_at, :date, :comment => "the SYSDATE when the last/next attempt was/will be happen"
    add_column :bm_aggregator_payments, :customer_id, :string, :limit => 50, :null => false, :default => '1', :comment => "the unique id of the customer that initiated the request"
    add_column :bm_aggregator_payments, :rmtr_name, :string, :limit => 50, :null => false, :default => 'a', :comment => "the full name of the sender"
    add_column :bm_aggregator_payments, :service_id, :string, :limit => 255, :comment => ""
    add_column :bm_aggregator_payments, :bene_name, :string, :limit => 255, :comment => "the full name of the beneficiary"
  end
end
