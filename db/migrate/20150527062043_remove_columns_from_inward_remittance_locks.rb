class RemoveColumnsFromInwardRemittanceLocks < ActiveRecord::Migration
  def change
    remove_column :inward_remittances_locks, :req_no
    remove_column :inward_remittances_locks, :parter_code
  end
end
