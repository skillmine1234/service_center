class AddRepDetailToBmBillPayments < ActiveRecord::Migration
  def change
    add_column :bm_bill_payments, :rep_no, :string, :limit => 32
    add_column :bm_bill_payments, :rep_version, :string, :limit => 5
    add_column :bm_bill_payments, :rep_timestamp, :datetime
  end
end
