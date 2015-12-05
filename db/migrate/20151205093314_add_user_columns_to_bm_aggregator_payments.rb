class AddUserColumnsToBmAggregatorPayments < ActiveRecord::Migration
  def change
    add_column :bm_aggregator_payments, :created_by, :string, limit: 20
    add_column :bm_aggregator_payments, :updated_by, :string, limit: 20
  end
end
