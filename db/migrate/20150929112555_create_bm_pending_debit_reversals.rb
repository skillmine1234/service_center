class CreateBmPendingDebitReversals < ActiveRecord::Migration
  def change
    create_table :bm_pending_debit_reversals do |t|
      t.string :broker_uuid, :null => false , :comment => 'the UUID of the broker that will process this request'
      t.integer :bm_bill_payment_id, :null => false, :comment => 'the foreign-key that references to bm_bill_payments'
      t.datetime :created_at, :null => false, :comment => 'the SYSDATE when this record was created'
    end
  end
end
