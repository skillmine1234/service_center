class RemoveIndexOnInwardRemittanceId < ActiveRecord::Migration
  def change
    remove_index :inw_audit_logs, :inward_remittance_id
  end
end
