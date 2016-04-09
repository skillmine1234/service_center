class CreateTableIcPaynows < ActiveRecord::Migration
  def change
    
      create_table :ic_paynows, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
        t.string :req_no, :limit => 255, :null => false, :comment =>"the unique reference number to be sent by the client application"    
        t.integer :attempt_no, :null => false, :comment => "the attempt number of the request, failed requests can be retried"
        t.string :status_code, :limit => 50, :null => false, :comment => "the status of this request"           
        t.string :req_version, :limit => 20, :null => false, :comment => "the service version number received in the request"
        t.datetime :req_timestamp, :null => false, :comment => "the SYSDATE when the request was sent to the service provider"
        t.string :app_id, :limit => 20, :null => false, :comment => "the identifier for the client"
        t.string :customer_id, :limit => 50, :null => false, :comment => "the unique code of the customer"
        t.string :supplier_code, :limit => 50, :null => false, :comment => "the unique code of the supplier"     
        t.string :invoice_no, :limit => 50, :null => false, :comment =>"the unique number of the invoice"   
        t.datetime :invoice_date, :null => false, :comment =>"the date of the invoice"   
        t.datetime :invoice_due_date,  :null => false, :comment =>"the due date of the invoice"   
        t.number :invoice_amount, :null => false, :comment =>"the amount of the invoice "   
        t.number :discounted_amount, :null => false,  :comment =>"the amount to be paid to supplier after deducting fee amount from invoice amount"   
        t.number :fee_amount, :null => false, :limit => 1, :comment =>"the fee amount in the request"   
        t.string :rep_no,  :limit => 255, :comment =>"the unique response number sent back by the API"
        t.string :rep_version, :limit => 20, :comment =>"the service version sent in the reply"   
        t.datetime :rep_timestamp,  :comment =>"the SYSDATE when the reply was sent to the client"
        t.string :credit_reference_no, :limit => 255, :comment =>"the reference no returned by flexcube"      
        t.string :fault_code, :limit => 50, :comment => "the code that identifies the business failure reason/exception"
        t.string :fault_reason, :limit => 1000, :comment => "the english reason of the business failure reason/exception"
        
        t.index([:req_no, :app_id, :attempt_no, :customer_id], :unique => true, :name => 'uk_ic_paynows_1')
    end
  end
end
