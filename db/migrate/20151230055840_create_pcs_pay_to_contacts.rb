class CreatePcsPayToContacts < ActiveRecord::Migration
  def change
    create_table :pcs_pay_to_contacts do |t|
      t.string :req_no, :limit => 32, :null => false, :comment =>  "the unique request number sent by the client"
      t.string :app_id, :limit => 32, :null => false, :comment => "the identifier for the client"
      t.integer :attempt_no, :null => false, :comment => "the attempt number of the request, failed requests can be retried"
      t.string :status_code, :limit => 25, :null => false, :comment => "the status of this request"
      t.string :req_version, :limit => 5, :null => false, :comment => "the service version number received in the request"
      t.datetime :req_timestamp, :comment => "the SYSDATE when the request was sent to the service provider"
      t.string :mobile_no, :limit => 255, :comment => "the mobile no of the customer"
      t.string :contact_name, :limit => 255, :comment => "the contact name"
      t.string :contact_mobile_no, :limit => 255, :comment => "the mobile number of the contact, to which the link to claim the amount will be sent"
      t.string :encrypted_pin, :limit => 255, :comment => "the encrypted PIN is required to process every financial transaction"
      t.string :transfer_amount, :limit => 255, :comment => "the transfer amount"
      t.string :rep_no, :limit => 32, :comment => "the unique response number sent back by the API"
      t.string :rep_version, :limit => 5, :comment => "the service version sent in the reply"
      t.string :req_ref_no, :limit => 50, :comment => "the unique request no which will be sent to FCR"
      t.integer :service_charge, :comment => "the service charge applied for the transaction, exclusive of tax"
      t.string :txn_uid, :comment => "the unique id of the debit transaction which MM api returns"
      t.string :rep_ref_no, :limit => 50, :comment => "the unique response no which FLEXCUBE will return"
      t.datetime :rep_timestamp, :comment => "the SYSDATE when the reply was sent to the client"
      t.string :fault_code, :limit => 255, :comment => "the code that identifies the business failure reason/exception"
      t.string :fault_reason, :limit => 1000, :comment => "the english reason of the business failure reason/exception "
      t.index([:req_no, :app_id, :attempt_no], :unique => true, :name => 'uk_pcs_pay_to_contacts')
    end
  end
end
