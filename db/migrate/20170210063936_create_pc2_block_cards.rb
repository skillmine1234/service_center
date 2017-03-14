class CreatePc2BlockCards < ActiveRecord::Migration
  def change
    create_table :pc2_block_cards, {:sequence_start_value => '1 cache 20 order increment by 1'}  do |t|
      t.string :req_no, :limit => 255, :null => false, :comment => "the unique reference number to be sent by the client application"
      t.integer :attempt_no, :null => false, :comment => "the attempt number of the request, failed requests can be retried"
      t.string :status_code, :limit => 25, :null => false, :comment => "the status of this request"
      t.string :req_version, :limit => 10, :null => false, :comment => "the service version number received in the request"
      t.datetime :req_timestamp, :null => false, :comment => "the SYSDATE when the request was sent to the service provider"
      t.string :app_id, :limit => 50, :null => false, :comment => "the identifier for the client"
      t.string :customer_id, :null => false, :limit => 50, :comment => "the unique no of the customer"
      t.string :proxy_card_no, :null => false, :limit => 50, :comment => "the proxy card number is used instead of the real card number to ensure security."
      t.datetime :rep_timestamp, :comment => "the SYSDATE when the reply was sent to the client"
      t.string :fault_code, :limit => 50, :comment => "the code that identifies the business failure reason/exception"
      t.string :fault_subcode, :limit => 50, :comment => "the diagnositc code that represents the failure reason/exception"
      t.string :fault_reason, :limit => 1000, :comment => "the english reason of the business failure reason/exception"
      t.index([:req_no, :app_id, :attempt_no], :unique => true, :name => 'uk_pc2_block_cards')      
    end
  end
end
