class AddDebitFeeStatusToPcsPayToContacts < ActiveRecord::Migration
  def change
    add_column :pcs_pay_to_contacts, :debit_fee_status, :string, :limit => 50
    add_column :pcs_pay_to_contacts, :debit_fee_result, :string, :limit => 1000
  end
end
