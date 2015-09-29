class CreateBmAuditLogs < ActiveRecord::Migration
  def change
    create_table :bm_audit_logs do |t|
      t.string :app_id, :limit => 50, :null => false, :comment => 'the identifier for the client'
      t.string :req_no, :null => false, :comment => 'the unique request number sent by the client'
      t.integer :attempt_no, :null => false, :comment => 'the attempt number of the request, failed requests can be retried'
      t.string :status_code, :limit => 25, :null => false, :comment => 'the status of this request'
      t.string :bm_auditable_type, :limit => 50, :null => false, :comment => 'the name of the table that represents the request that is related to this record'
      t.integer :bm_auditable_id, :null => false, :comment => 'the id of the row that represents the request that is related to this recrod'
      t.string :fault_code, :limit => 50, :comment => 'the code that identifies the exception, if an exception occured in the ESB'
      t.string :fault_reason, :limit => 1000, :comment => 'the english reason of the exception, if an exception occurred in the ESB'
      t.text :req_bitstream, :comment => 'the full request payload as received from the client'
      t.datetime :req_timestamp, :comment => 'the SYSDATE when the request was received from the client'
      t.text :rep_bitstream, :comment => 'the full reply payload as sent to the client'
      t.datetime :rep_timestamp, :comment => 'the SYSDATE when the reply was sent to the client'
      t.text :fault_bitstream, :comment => 'the complete exception list/stack trace of an exception that occured in the ESB'
    end
  end
end
