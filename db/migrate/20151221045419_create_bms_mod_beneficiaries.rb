class CreateBmsModBeneficiaries < ActiveRecord::Migration
  def change
    create_table :bms_mod_beneficiaries do |t|
      t.string :req_version, :null => false, :comment => "the service version number received in the request"
      t.string :req_no, :null => false, :comment =>  "the unique request number sent by the client"
      t.integer :attempt_no, :null => false, :comment => "the attempt number of the request, failed requests can be retried"
      t.string :status_code, :limit => 25, :null => false, :comment => "the status of this request"
      t.datetime :req_timestamp, :comment => "the SYSDATE when the request was sent to the service provider"
      t.string :app_id, :null => false, :comment => "the identifier for the client"
      t.string :customer_id, :null => false, :comment => 'the unique id of the customer that initiated the request'
      t.string :bene_id, :comment => "the id that identifies the beneficiary"
      t.string :transfer_type, :comment => "the payment network that needs to be used"
      t.string :bene_name, :comment => "the name of the benefciary to whom amount should be transferred"
      t.string :bene_acct_no, :comment => "the account no of the beneficiary"
      t.string :bene_acct_ifsc, :comment => "the ifsc code of the beneficiary"
      t.string :bene_description, :comment => "nickname of the beneficiary"
      t.string :bene_email_id, :comment => "the email id of the beneficiary"
      t.string :bene_mobile_no, :comment => "the mobile no of the beneficiary"
      t.string :otp_key, :comment => "the secret key of the OTP which is generated by the server and sent back as part of the response"
      t.string :otp_value, :comment => "the value provided by the user"
      t.string :rep_version, :comment => 'the service version sent in the reply'
      t.string :rep_no, :comment => 'the unique number sent as part of the reply'
      t.datetime :rep_timestamp, :comment => "the SYSDATE when the reply was sent to the client"
      t.string :fault_code, :limit => 255, :comment => "the code that identifies the business failure reason/exception"
      t.string :fault_reason, :limit => 1000, :comment => "the english reason of the business failure reason/exception"
      t.index([:req_no, :app_id, :attempt_no], :unique => true, :name => 'uk_bms_mod_beneficiaries_1')
    end
  end
end
