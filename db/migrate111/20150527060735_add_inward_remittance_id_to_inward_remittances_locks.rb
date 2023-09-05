class AddInwardRemittanceIdToInwardRemittancesLocks < ActiveRecord::Migration[7.0]
  def change
    add_column :inward_remittances_locks, :inward_remittance_id, :integer
  end
end
