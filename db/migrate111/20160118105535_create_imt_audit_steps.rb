class CreateImtAuditSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :imt_audit_steps do |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :imt_auditable_type, :null => false, :comment => "the name of the table that represents the request that is related to this record"
      t.integer :imt_auditable_id, :null => false, :comment => "the id of the row that represents the request that is related to this recrod"
      t.integer :step_no, :null => false, :comment => 'the step of the transaction, for which this record exists'
      t.integer :attempt_no, :null => false , :comment => 'the attempt number of the request, failed requests can be retried'
      t.string :step_name, :limit => 100, :null => false, :comment => 'the english name of the step: create user, request token, access token, modify user, add address, add card, activate card'
      t.string :status_code, :limit => 25, :null => false, :comment => 'the status of this attempt of the step'
      t.string :fault_code, :limit => 255, :comment => 'the code that identifies the exception, if an exception occured in the ESB'
      t.string :fault_reason, :limit => 1000, :comment => 'the english reason of the exception, if an exception occurred in the ESB'
      t.string :req_reference, :limit => 255, :comment => 'the reference number that was sent to the service provider'
      t.datetime :req_timestamp, :comment => 'the SYSDATE when the request was sent to the service provider'
      t.string :rep_reference, :comment => 'the reference number as received from ther service provider'
      t.datetime :rep_timestamp, :comment => 'the SYSDATE when the reply was sent to the client'
      t.text :req_bitstream, :comment => 'the full request payload as received from the client'
      t.text :rep_bitstream, :comment => 'the full reply payload as sent to the client'
      t.text :fault_bitstream, :comment => 'the complete exception list/stack trace of an exception that occured in the ESB'  
      t.index([:imt_auditable_type, :imt_auditable_id, :step_no, :attempt_no], :unique => true, :name => "uk_imt_audit_steps")
    end
  end
end
