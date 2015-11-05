class AddNewColumnsToBmAggregatorPayments < ActiveRecord::Migration
  def change
    add_column :bm_aggregator_payments, :status, :string, :limit => 50, :null => false, :default => ""
    add_column :bm_aggregator_payments, :fault_code, :string, :limit => 50
    add_column :bm_aggregator_payments, :fault_reason, :string, :limit => 1000
    add_column :bm_aggregator_payments, :neft_req_ref, :string, :limit => 64
    add_column :bm_aggregator_payments, :neft_attempt_no, :integer
    add_column :bm_aggregator_payments, :neft_attemp_at, :date
    add_column :bm_aggregator_payments, :neft_rep_ref, :string, :limit => 64
    add_column :bm_aggregator_payments, :neft_completed_at, :date
  end
end
