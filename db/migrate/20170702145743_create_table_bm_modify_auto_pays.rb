class CreateTableBmModifyAutoPays < ActiveRecord::Migration
  def change
    create_table :bm_modify_auto_pays, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
     t.string :app_id, :limit => 50, :null => false, :comment => "the identifier for the client"
     t.string :req_no, :limit => 32, :null => false, :comment => "the unique request number sent by the client"
     t.integer :attempt_no, :null => false, :comment => "the attempt number of the request, failed requests can be retried"
     t.string :req_version, :limit => 5, :null => false, :comment => "the service version number received in the request"
     t.datetime :req_timestamp, :null => false, :comment => "the SYSDATE when the request was received"
     t.string :customer_id, :limit => 15, :null => false, :comment => "the unique id of the customer that initiated the request"
     t.string :biller_code, :limit => 50, :comment => "the biler code of the customer"
     t.string :biller_acct_no, :limit => 50, :comment => "the biller account generated for the customer"
     t.string :status_code, :limit => 50, :null => false, :comment => "the status of this request"
     t.number :amount_limit, :limit => 50, :comment => "the limit of the amount for autopay"
     t.datetime :start_date, :comment => "the start date of the autopay"
     t.datetime :end_date, :comment => "the end date of the autopay"
     t.string :interval, :limit => 50, :comment => "the number of times in a particular period eg: monthly, yearly"
     t.string :email_id1, :limit => 100, :comment => "the registered first email id of the customer"
     t.string :email_id2, :limit => 100, :comment => "the registered second email id of the customer"
     t.string :mobile_no, :limit => 50, :comment => "the registered mobile number of the customer"
     t.string :rep_version, :limit => 5, :comment => "the service version sent in the reply"
     t.string :rep_no, :limit => 32, :comment => "the unique number sent as part of the reply"
     t.datetime :rep_timestamp, :comment => "the SYSDATE when the reply was sent to the client"
     t.string :fault_code, :limit => 50, :comment => "the code that identifies the business failure reason/exception"
     t.string :fault_reason, :limit => 1000, :comment => "the english reason of the business failure reason/exception"
    end
  end
end
