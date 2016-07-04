class ChangeTimestampColumnsFmAuditSteps < ActiveRecord::Migration
  def up
    change_column :fm_audit_steps, :rep_timestamp, :timestamp, :comment => 'the SYSDATE when the reply was sent to the client'
    change_column :fm_audit_steps, :req_timestamp, :timestamp, :comment => 'the SYSDATE when the request was sent to the service provider'
  end
end
