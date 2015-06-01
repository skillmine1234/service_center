class AddInwardRemittanceIdToInwardRemittancesLocks < ActiveRecord::Migration
  def change
    add_column :inward_remittances_locks, :inward_remittance_id, :integer
  end
end
