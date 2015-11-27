class RemoveColumnsFromBmAggregatorPayments < ActiveRecord::Migration
  def change
    remove_column :bm_aggregator_payments, :neft_attemp_at
    remove_column :bm_aggregator_payments, :bene_account_ifsc
  end
end
