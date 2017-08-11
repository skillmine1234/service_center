class CreateIamAuditLogs < ActiveRecord::Migration
  def change
    create_table :iam_audit_logs , {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :org_uuid, limit: 255, null: false, comment: 'the UUID of the organisation as available in DP'
      t.string :cert_dn, limit: 255, comment: 'to specify the DN of the certificate (required when then customer is not using VPN)'
      t.string :source_ip, limit: 4000, comment: 'the source ip-address (required when the customer is not using VPN)'            
      t.text :req_bitstream, :comment => 'the full request payload as received from the client'
      t.datetime :req_timestamp, :null => false, :comment => "the SYSDATE when the request was received"
      t.datetime :rep_timestamp, :comment => "the SYSDATE when the reply was sent to the client"
      t.string :fault_code, :limit => 50, :comment => "the code that identifies the business failure reason/exception"
      t.string :fault_reason, :limit => 1000, :comment => "the english reason of the business failure reason/exception"
    end    
  end
end
