class AddUniqueIndexOnBmBillPayments < ActiveRecord::Migration
  def change
    add_index :bm_bill_payments, :billpay_rep_ref, :unique => true, :name => "uk_billpay_rep_ref"
  end
end
