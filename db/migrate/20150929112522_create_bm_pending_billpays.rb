class CreateBmPendingBillpays < ActiveRecord::Migration
  def change
    create_table :bm_pending_billpays, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :broker_uuid, :null => false , :comment => 'the UUID of the broker that will process this request'
      t.integer :bm_bill_payment_id, :null => false, :comment => 'the foreign-key that references to bm_bill_payments'
      t.datetime :created_at, :null => false, :comment => 'the SYSDATE when this record was created'
    end
  end
end
