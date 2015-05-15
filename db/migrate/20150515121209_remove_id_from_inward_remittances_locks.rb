class RemoveIdFromInwardRemittancesLocks < ActiveRecord::Migration
  def change
    remove_column :inward_remittances_locks, :id
  end
end
