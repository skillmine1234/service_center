class AddPendingApprovalColumnToBmBillPayments < ActiveRecord::Migration
  def change
    add_column :bm_bill_payments, :pending_approval, :string, :limit => 1, :default => 'Y'
  end
end
