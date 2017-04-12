class AddIndexInBmBillPayments < ActiveRecord::Migration
  def change
    add_index :bm_bill_payments, [:status,:txn_kind,:req_timestamp], name: 'bm_bill_payments_01' 
  end
end
