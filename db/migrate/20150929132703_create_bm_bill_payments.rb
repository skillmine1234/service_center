class CreateBmBillPayments < ActiveRecord::Migration[7.0]
  def change
    create_table :bm_bill_payments do |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :app_id, :limit => 50, :null => false, :comment => 'the identifier for the client'
      t.string :req_no, :limit => 32, :null => false, :comment => 'the unique request number sent by the client'
      t.integer :attempt_no, :null => false, :comment => 'the attempt number of the request, failed requests can be retried'
      t.string :req_version, :limit => 5, :null => false, :comment => 'the service version number received in the request'
      t.datetime :req_timestamp, :null => false, :comment => 'the SYSDATE when the request was received'
      t.string :customer_id, :limit => 15, :null => false, :comment => 'the unique id of the customer that initiated the request'
      t.string :debit_account_no, :limit => 50, :null => false, :comment => 'the account chosen by the customer to be debited'
      t.string :txn_kind, :limit => 50, :null => false, :comment => 'the kind of the transaction: specifies which of biller_code, biller_account_no, bill_id will be available'
      t.integer :txn_amount, :null => false, :comment => 'the transaction amount'
      t.string :biller_code, :limit => 50, :null => false, :comment => 'the biller account registered for the customer, this identifies the biller and parameters'
      t.string :biller_acct_no, :limit => 50, :comment => 'the biller account registered for the customer, this identifies the biller and parameters'
      t.string :bill_id, :limit => 50, :comment => 'the unique identifier of the bill, as received in getBill operation'
      t.string :status, :limit => 50, :null => false, :comment => 'the status of the transaction'
      t.string :fault_code, :limit => 50, :comment => 'the code that identifies the business failure reason/exception'
      t.string :fault_reason, :limit => 1000, :comment => 'the english reason of the business failure reason/exception '
      t.string :debit_req_ref, :limit => 64, :comment => 'the reference number of the debit request'
      t.integer :debit_attempt_no, :comment => 'the last attempt no of the debit request'
      t.datetime :debit_attempt_at, :comment => 'the SYSDATE when the last/next attempt was/will happen'
      t.string :debit_rep_ref, :limit => 64, :comment => 'the reference number as received in the debit reply'
      t.datetime :debited_at, :comment => 'the SYSDATE when the debit completed'
      t.string :billpay_req_ref, :limit => 64, :comment => 'the reference number of the bill payment request'
      t.integer :billpay_attempt_no, :comment => 'the last attempt no of the bill payment request'
      t.datetime :billpay_attempt_at, :comment => 'the SYSDATE when the last/next attempt was/will happen'
      t.string :billpay_rep_ref, :limit => 64, :comment => 'the reference number as received in the billpay reply'
      t.datetime :billpaid_at, :comment => 'the SYSDATE when the billpay completed'
      t.string :reversal_req_ref, :limit => 64, :comment => 'the reference number of the debit reversal'
      t.integer :reversal_attempt_no, :comment => 'the last attempt no of the debit reversal '
      t.datetime :reversal_attempt_at, :comment => 'the SYSDATE when the last/next attempt was/will happen'
      t.string :reversal_rep_ref, :limit => 64, :comment => 'the reference number as received in the reversal reply'
      t.datetime :reversal_at, :comment => 'the SYSDATE when the reversal reply was received'
      t.string :refund_ref, :limit => 64, :comment => 'the reference number of the refund transaction'
      t.datetime :refund_at, :comment => 'the SYSDATE when the refund was completed'
      t.string :is_reconciled, :limit => 1, :comment => 'the status indicator to denote reconciled payments'
      t.datetime :reconciled_at, :comment => 'the SYSDATE when the transaction was reconciled'
    end

    add_index :bm_bill_payments, [:app_id, :req_no, :attempt_no], :unique => true, :name => 'attepmt_index_bill_payments'
  end
end
