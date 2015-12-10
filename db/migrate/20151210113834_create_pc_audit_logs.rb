class CreatePcAuditLogs < ActiveRecord::Migration
  def change
    create_table :pc_audit_logs do |t|
      t.string :req_no, :limit => 32, :null => false, :comment =>  "the unique request number sent by the client"
      t.string :app_id, :limit => 32, :null => false, :comment => "the identifier for the client"
      t.integer :attempt_no, :null => false, :comment => "the attempt number of the request, failed requests can be retried"
      t.string :status_code, :limit => 25, :null => false, :comment => "the status of this request"
      t.string :pc_auditable_type, :limit => 255, :null => false, :comment => "the name of the table that represents the request that is related to this record"
      t.integer :pc_auditable_id, :null => false, :comment => "the id of the row that represents the request that is related to this recrod"
      t.string :fault_code, :limit => 255, :comment => "the code that identifies the exception, if an exception occured in the ESB"
      t.string :fault_reason, :limit => 1000, :comment => "the english reason of the exception, if an exception occurred in the ESB"
      t.text :req_bitstream, :null => false, :comment => "the full request payload as received from the client"
      t.datetime :req_timestamp, :comment => "the SYSDATE when the request was received from the client"
      t.text :rep_bitstream, :comment => "the full reply payload as sent to the client"
      t.datetime :rep_timestamp, :comment => "the SYSDATE when the reply was sent to the client"
      t.text :fault_bitstream, :comment => "the complete exception list/stack trace of an exception that occured in the ESB"
    end
    add_index :pc_audit_logs, [:req_no, :app_id, :attempt_no], :unique => true
    add_index :pc_audit_logs, [:pc_auditable_type, :pc_auditable_id], :unique => true
  end
end
