class ChangeIndexOnSmPayments < ActiveRecord::Migration
  def change
    remove_index :sm_payments, :name => 'sm_payments_01'
    add_index "sm_payments", ["partner_code", "req_no", "attempt_no"], name: "sm_payments_01", unique: true
  end
end
