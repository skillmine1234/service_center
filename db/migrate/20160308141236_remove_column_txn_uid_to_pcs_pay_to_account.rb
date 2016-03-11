class RemoveColumnTxnUidToPcsPayToAccount < ActiveRecord::Migration
  def change
    remove_column :pcs_pay_to_accounts, :txn_uid
  end
end
