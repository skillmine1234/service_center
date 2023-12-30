class AddBillpayBankRefToBmBillPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :bm_bill_payments, :billpay_bank_ref, :string, :limit => 20
  end
end
