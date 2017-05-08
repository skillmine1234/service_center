class CreateIc001IncomingRecords < ActiveRecord::Migration
  def change
    create_table :ic_001_incoming_records, {:sequence_start_value => '1 cache 20 order increment by 1'}  do |t|
      t.integer :incoming_file_record_id, :comment => "the foreign key to the incoming_files table" 
      t.string  :file_name, :limit => 100, :comment => "the name of the incoming_file"    
      t.string  :anchor_cust_id, :limit => 50,:comment => "the customer id of the customers"         
      t.string  :anchor_account_id, :limit => 50,:comment => "the account id of the customer"         
      t.string  :dealer_account_id, :limit => 50,:comment => "the account id if the supplier"         
      t.string  :dealer_cust_id, :limit => 50,:comment => "the customer id of the supplier"         
      t.number  :drawdown_amount, :comment => "the discounted amount"
      t.string  :remarks, :limit => 255,:comment => "the customer remorks for the transactions"                        
      t.string  :invoice_no, :limit => 50,:comment => "the invoice number from the customer for this transaction"         
      t.number  :invoice_amount, :comment => "the invoice amount"         
      t.date  :book_date, :comment => "the book date of the transaction"         
      t.string  :additional_field1, :limit => 50,:comment => "the additional field which contains unique request number for the transaction"                                       
      t.string  :additional_field2, :limit => 50,:comment => "the additional field which contains supplier code"         
      t.string  :status, :limit => 50,:comment => "the status which contains the flag to identify the transaction status"         
      t.string  :failure_reason, :limit => 255,:comment => "the reason for the failure"                                       
      t.string  :ref_number, :limit => 50,:comment => "the reference number for the transaction"         
      t.index([:incoming_file_record_id,:file_name], :unique => true, :name => 'ic_001_incoming_records_01')                   
    end
  end
end
