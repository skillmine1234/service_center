class MakeBillerCodeNotNummInBmBillPayments < ActiveRecord::Migration
  def change
    change_column :bm_bill_payments, :biller_code, :string, :limit => 50, :null => true
  end
end
