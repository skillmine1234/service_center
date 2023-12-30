class RemoveIdFromInwardRemittancesLocks < ActiveRecord::Migration[7.0]
  def change
    remove_column :inward_remittances_locks, :id
  end
end
