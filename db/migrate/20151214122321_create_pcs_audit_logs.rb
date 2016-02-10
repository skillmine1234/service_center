class CreatePcsAuditLogs < ActiveRecord::Migration
  def change
    create_table :pcs_audit_logs, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :req_no, :limit => 32, :null => false, :comment =>  "the unique request number sent by the client"
      t.string :app_id, :limit => 32, :null => false, :comment => "the identifier for the client"
      t.integer :attempt_no, :null => false, :comment => "the attempt number of the request, failed requests can be retried"
      t.string :status_code, :limit => 25, :null => false, :comment => "the status of this request"
      t.string :pcs_auditable_type, :limit => 255, :null => false, :comment => "the name of the table that represents the request that is related to this record"
      t.integer :pcs_auditable_id, :null => false, :comment => "the id of the row that represents the request that is related to this recrod"
      t.string :fault_code, :limit => 255, :comment => "the code that identifies the exception, if an exception occured in the ESB"
      t.string :fault_reason, :limit => 1000, :comment => "the english reason of the exception, if an exception occurred in the ESB"
      t.datetime :req_timestamp, :comment => "the SYSDATE when the request was received from the client"
      t.datetime :rep_timestamp, :comment => "the SYSDATE when the reply was sent to the client"
      t.text :req_bitstream, :null => false, :comment => "the full request payload as received from the client"
      t.text :rep_bitstream, :comment => "the full reply payload as sent to the client"
      t.text :fault_bitstream, :comment => "the complete exception list/stack trace of an exception that occured in the ESB"
      t.index([:app_id, :req_no, :attempt_no], :unique => true, :name => 'uk_pcs_audit_logs_1')
      t.index([:pcs_auditable_type, :pcs_auditable_id], :unique => true, :name => 'uk_pcs_audit_logs_2')
    end
  end
end
