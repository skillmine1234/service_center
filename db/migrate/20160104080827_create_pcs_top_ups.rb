class CreatePcsTopUps < ActiveRecord::Migration
  def change
    create_table :pcs_top_ups do |t|
      t.string :req_no, :limit => 255, :null => false, :comment => "the unique reference number to be sent by the client application"
      t.integer :attempt_no, :null => false, :comment => "the attempt number of the request, failed requests can be retried"
      t.string :status_code, :limit => 25, :null => false, :comment => "the status of this request"
      t.string :req_version, :limit => 10, :null => false, :comment => "the service version number received in the request"
      t.datetime :req_timestamp, :null => false, :comment => "the SYSDATE when the request was sent to the service provider"
      t.string :app_id, :limit => 50, :null => false, :comment => "the identifier for the client"
      t.string :mobile_no, :limit => 50, :comment => "the mobile no of the customer"
      t.string :encrypted_pin, :limit => 50, :comment => "the encrypted PIN is required to process every financial transaction"
      t.string :biller_id, :limit => 50
      t.string :subscriber_id, :limit => 50
      t.number :transfer_amount, :comment => "the transfer amount"
      t.string :rep_no, :limit => 255, :comment => "the unique response number sent back by the API"
      t.string :rep_version, :limit => 10, :comment => "the service version sent in the reply"
      t.datetime :rep_timestamp, :comment => "the SYSDATE when the reply was sent to the client"
      t.number :service_charge, :comment => "the service charge applied for the transaction, exclusive of tax"
      t.string :txn_uid, :limit => 50, :comment => "the unique id of the debit transaction which MM api returns"
      t.string :debit_ref_no, :limit => 50, :comment => "the reference number of the account debit, as seen in the account statement"
      t.string :biller_ref_no, :limit => 50, :comment => "the reference number of the bill payment, as known to the aggregator"
      t.string :debit_fee_status, :limit => 50, :comment => "the status of debit fee"
      t.string :debit_fee_result, :limit => 1000, :comment => "the english reason of the business failure reason/exception"
      t.string :fault_code, :limit => 50, :comment => "the code that identifies the business failure reason/exception"
      t.string :fault_reason, :limit => 1000, :comment => "the english reason of the business failure reason/exception"
      t.timestamps null: false
      t.index([:req_no, :app_id, :attempt_no], :unique => true, :name => 'uk_pcs_top_ups')
    end
  end
end
