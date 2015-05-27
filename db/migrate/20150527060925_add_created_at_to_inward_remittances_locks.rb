class AddCreatedAtToInwardRemittancesLocks < ActiveRecord::Migration
  def change
    add_column :inward_remittances_locks, :created_at, :string
  end
end
