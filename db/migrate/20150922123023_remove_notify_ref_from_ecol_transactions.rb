class RemoveNotifyRefFromEcolTransactions < ActiveRecord::Migration
  def change
    remove_column :ecol_transactions, :notify_ref
  end
end
