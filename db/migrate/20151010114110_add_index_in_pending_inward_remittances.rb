class AddIndexInPendingInwardRemittances < ActiveRecord::Migration
  def change
    add_index :pending_inward_remittances, :inward_remittance_id, :unique => true
  end
end
