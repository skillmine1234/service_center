class RemoveUniqueIndexFromBmBillPayments < ActiveRecord::Migration
  def change
    remove_index :bm_bill_payments, :name => "uk_billpay_rep_ref"
  end
end
