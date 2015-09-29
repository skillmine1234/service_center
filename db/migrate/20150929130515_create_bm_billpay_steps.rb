class CreateBmBillpaySteps < ActiveRecord::Migration
  def change
    create_table :bm_billpay_steps do |t|
      t.integer :bm_bill_payment_id, :null => false, :comment => 'the foreign-key that references to bm_bill_payments'
      t.integer :step_no, :null => false, :comment => 'the step of the transaction, for which this record exists'
      t.integer :attempt_no, :null => false , :comment => 'the attempt no of the step, for which this record exists'
      t.string :step_name, :limit => 100, :null => false, :comment => 'the english name of the step: debit, billpay, reversal'
      t.string :status_code, :limit => 25, :null => false, :comment => 'the status of this attempt of the step'
      t.string :fault_code, :limit => 50, :comment => 'the code that identifies the business failure reason/exception'
      t.string :fault_reason, :limit => 1000, :comment => 'the english reason of the business failure reason/exception '
      t.string :req_reference, :comment => 'the reference number that was sent to the service provider'
      t.text :req_bitstream, :comment => 'the full request payload as sent to the service provider'
      t.datetime :req_timestamp, :comment => 'the SYSDATE when the request was sent to the service provider'
      t.string :rep_reference, :comment => 'the reference number as received from ther service provider'
      t.text :rep_bitstream, :comment => 'the full reply payload as received from the service provider'
      t.datetime :rep_timestamp, :comment => 'the SYSDATE when the reply was received from the service provider'
      t.text :fault_bitstream, :comment => 'the complete exception list/stack trace of an exception that occured in the ESB'      
    end

    add_index :bm_billpay_steps, [:bm_bill_payment_id, :step_no, :attempt_no], :unique => true, :name => 'attepmt_no_index_billpay_steps'
  end
end
