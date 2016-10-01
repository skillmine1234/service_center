class CreateRcTransfers < ActiveRecord::Migration
  def change
    create_table :rc_transfers, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :rc_transfer_code, :limit => 50, :comment => 'the unique code for the beneficiary'  
      t.integer :batch_no, :comment => 'the unique code for the beneficiary'  
      t.string :status_code, :limit => 50, :comment => 'the unique code for the beneficiary'  
      t.datetime :started_at, :comment => 'the unique code for the beneficiary'  
      t.string :debit_account_no, :limit => 20, :comment => 'the account no of the provider, from where amount needs to be transferred'      
      t.string :bene_account_no, :limit => 20, :comment => 'the account no of the beneficiary, where amount needs to be transferred from provider account'      
      t.number :transfer_amount, :comment => 'the transfer amount'  
      t.string :transfer_req_ref, :limit => 50, :comment => 'the unique request reference number which we pass to flexcube for CREDIT step'  
      t.string :transfer_rep_ref, :limit => 50, :comment => 'the unique reply reference number which flexcube returns'  
      t.datetime :transferred_at, :comment => 'the timestamp when the credit was happened'  
      t.string :notify_status, :limit => 50, :comment => 'the status of notification'  
      t.integer :notify_attempt_no, :comment => 'the attempt no of the notify step'  
      t.datetime :notify_attempt_at, :comment => 'the last attempt of the notify step'  
      t.datetime :notified_at, :comment => 'the timestamp when the notification was happened'  
      t.string :notify_result, :limit => 50, :comment => 'the failure reason of the notify step'  
      t.string :fault_code, :limit => 255, :comment => 'the code that identifies the exception, if an exception occured in the ESB'
      t.string :fault_subcode, :limit => 50, :comment => "the error code that the third party will return"
      t.string :fault_reason, :limit => 1000, :comment => 'the english reason of the exception, if an exception occurred in the ESB'  
      t.index([:rc_transfer_code], :unique => false, :name => 'rc_transfers_01')      
    end
  end
end
