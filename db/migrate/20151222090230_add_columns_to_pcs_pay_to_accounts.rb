class AddColumnsToPcsPayToAccounts < ActiveRecord::Migration
  def change
    add_column :pcs_pay_to_accounts, :service_charge, :integer, :comment => "the service charge applied for the transaction, exclusive of tax"
    add_column :pcs_pay_to_accounts, :txn_uid, :string, :comment => "the unique id of the debit transaction which MM api returns"
  end
end
