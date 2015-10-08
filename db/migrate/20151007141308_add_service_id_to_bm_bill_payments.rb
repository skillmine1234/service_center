class AddServiceIdToBmBillPayments < ActiveRecord::Migration
  def change
    add_column :bm_bill_payments, :service_id, :string
  end
end
