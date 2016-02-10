class CreatePcBlockCards < ActiveRecord::Migration
  def change
    create_table :pc_block_cards, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :req_no, :limit => 32, :null => false, :comment =>  "the unique request number sent by the client"
      t.string :app_id, :limit => 32, :null => false, :comment => "the identifier for the client"
      t.integer :attempt_no, :null => false, :comment => "the attempt number of the request, failed requests can be retried"
      t.string :status_code, :limit => 25, :null => false, :comment => "the status of this request"
      t.string :req_version, :limit => 5, :null => false, :comment => "the service version number received in the request"
      t.datetime :req_timestamp, :comment => "the SYSDATE when the request was sent to the service provider"
      t.string :mobile_no, :limit => 255, :comment => "the mobile no of the customer that initiated the request"
      t.string :email_id, :limit => 255, :comment => "the email id of the customer which is derived by customer mobile no"
      t.string :cust_uid, :limit => 255, :comment => "the unique no of the customer"
      t.string :password, :limit => 255, :comment => "the password of the customer which is derived by customer mobile no"
      t.string :rep_no, :limit => 32, :comment => "the unique response number sent back by the API"
      t.string :rep_version, :limit => 5, :comment => "the service version sent in the reply"
      t.datetime :rep_timestamp, :comment => "the SYSDATE when the reply was sent to the client"
      t.string :fault_code, :limit => 255, :comment => "the code that identifies the business failure reason/exception"
      t.string :fault_reason, :limit => 1000, :comment => "the english reason of the business failure reason/exception"
      t.index([:req_no, :app_id, :attempt_no], :unique => true, :name => 'uk_pc_block_cards_1')
    end    
  end  
end
