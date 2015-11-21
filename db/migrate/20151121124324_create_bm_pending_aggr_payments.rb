class CreateBmPendingAggrPayments < ActiveRecord::Migration
  def change
    create_table :bm_pending_aggr_payments do |t|
      t.string :broker_uuid, :limit => 500
      t.references :bm_aggregator_payment
      t.datetime :created_at
    end
  end
end
