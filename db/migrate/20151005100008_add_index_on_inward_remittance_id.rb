class AddIndexOnInwardRemittanceId < ActiveRecord::Migration
  def change
    add_index :inw_audit_logs, :inward_remittance_id, :unique => true
  end
end
