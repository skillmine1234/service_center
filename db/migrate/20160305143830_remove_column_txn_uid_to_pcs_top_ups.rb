class RemoveColumnTxnUidToPcsTopUps < ActiveRecord::Migration
  def change
    remove_column :pcs_top_ups, :txn_uid
  end
end
