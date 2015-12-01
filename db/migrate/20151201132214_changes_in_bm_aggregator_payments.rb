class ChangesInBmAggregatorPayments < ActiveRecord::Migration
  def change
    remove_column :bm_aggregator_payments, :bank_ref
    change_column :bm_aggregator_payments, :pending_approval, :string, :limit => 1, :null => false, :default => 'N', :comment => "the indicator that denotes whether a human approval is awaited (Y) or not (N)"
    change_column :bm_aggregator_payments, :is_reconciled, :string, :limit => 1, :comment => "the indicator that denotes whether the transaction was reconciled (Y)"
    change_column :bm_aggregator_payments, :customer_id, :string, :limit => 50, :null => false, :default => ' ', :comment => "the unique id of the customer that initiated the request"
    change_column :bm_aggregator_payments, :rmtr_name, :string, :limit => 50, :null => false, :default => ' ', :comment => "the full name of the sender"
  end
end
