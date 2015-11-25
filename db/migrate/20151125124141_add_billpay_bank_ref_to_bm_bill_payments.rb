class AddBillpayBankRefToBmBillPayments < ActiveRecord::Migration
  def change
    add_column :bm_bill_payments, :billpay_bank_ref, :string, :limit => 20
  end
end
