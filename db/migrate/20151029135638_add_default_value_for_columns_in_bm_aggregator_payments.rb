class AddDefaultValueForColumnsInBmAggregatorPayments < ActiveRecord::Migration
  def change
    change_column :bm_aggregator_payments, :status, :string, :limit => 50, :null => false, :default => "NEW"
    change_column :bm_aggregator_payments, :approval_status, :string, :limit => 1, :null => false, :default => "U"
  end
end
