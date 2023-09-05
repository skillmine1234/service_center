class RemoveColumnsFromInwardRemittanceLocks < ActiveRecord::Migration[7.0]
  def change
    remove_column :inward_remittances_locks, :req_no
    remove_column :inward_remittances_locks, :partner_code
  end
end
