class AddCreatedAtToInwardRemittancesLocks < ActiveRecord::Migration[7.0]
  def change
    add_column :inward_remittances_locks, :created_at, :string
  end
end
