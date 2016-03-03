class RemoveColumnTxnUidToPcsPayToContacts < ActiveRecord::Migration
  def change
    remove_column :pcs_pay_to_contacts, :txn_uid
  end
end

