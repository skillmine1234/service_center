class BmBillPayment < ActiveRecord::Base  
  has_many :bm_billpay_steps

  validates_presence_of :app_id, :req_no, :attempt_no, :customer_id, :debit_account_no, :txn_kind,
                        :txn_amount, :status
                        
  def self.find_bm_bill_payments(bm_bill_payment,params)
    bill_payments = bm_bill_payment
    bill_payments = bill_payments.where("bm_bill_payments.status=?",params[:status]) if params[:status].present?
    bill_payments = bill_payments.where("pending_approval=?",params[:pending]) if params[:pending].present?
    bill_payments = bill_payments.where("lower(bm_bill_payments.req_no) LIKE ?","%#{params[:request_no].downcase}%") if params[:request_no].present?
    bill_payments = bill_payments.where("bm_bill_payments.customer_id=?",params[:cust_id]) if params[:cust_id].present?
    bill_payments = bill_payments.where("bm_bill_payments.debit_account_no=?",params[:debit_no]) if params[:debit_no].present?
    bill_payments = bill_payments.where("bm_bill_payments.txn_kind=?",params[:txn_kind]) if params[:txn_kind].present?
    bill_payments = bill_payments.where("bm_bill_payments.txn_amount>=? and bm_bill_payments.txn_amount <=?",params[:from_amount].to_f,params[:to_amount].to_f) if params[:to_amount].present? and params[:from_amount].present?
    bill_payments = bill_payments.where("bm_bill_payments.biller_code=?",params[:biller_code]) if params[:biller_code].present?
    bill_payments = bill_payments.where("bm_bill_payments.biller_acct_no=?",params[:biller_acct_no]) if params[:biller_acct_no].present?
    bill_payments = bill_payments.where("bm_bill_payments.bill_id=?",params[:bill_id]) if params[:bill_id].present?
    bill_payments = bill_payments.where("bm_bill_payments.billpaid_at>=? and bm_bill_payments.billpaid_at<=?",Time.zone.parse(params[:from_date]).beginning_of_day,Time.zone.parse(params[:to_date]).end_of_day) if params[:from_date].present? and params[:to_date].present?
    bill_payments = bill_payments.where("bm_bill_payments.billpaid_at>=?",Time.zone.parse(params[:from_date]).beginning_of_day) if params[:from_date].present? and params[:to_date].empty?
    bill_payments = bill_payments.where("bm_bill_payments.billpaid_at<=?",Time.zone.parse(params[:to_date]).end_of_day) if params[:to_date].present? and params[:from_date].empty?
    bill_payments
  end
                        
  def self.to_csv(csv_path, params)
    Delayed::Worker.logger.debug("called ")
    if params[:advanced_search].present? || params[:summary].present?
      requests = find_bm_bill_payments(self,params).order("id desc")
    else
      requests = all.order("id desc")
    end
    CSV.open(csv_path,'w') do |csv|
      csv << get_header
      requests.find_each(batch_size: 100) do |t|
        csv << [t.app_id, t.req_no, t.attempt_no, t.req_version, t.req_timestamp, t.customer_id, t.debit_account_no, t.txn_kind, 
                t.txn_amount, t.biller_code, t.biller_acct_no, t.bill_id, t.status, t.fault_code, t.fault_reason, t.debit_req_ref, 
                t.debit_attempt_no, t.debit_attempt_at, t.debit_rep_ref, t.debited_at, t.billpay_req_ref, t.billpay_attempt_no, 
                t.billpay_attempt_at, t.billpay_rep_ref, t.billpaid_at, t.reversal_req_ref, t.reversal_attempt_no, t.reversal_attempt_at, 
                t.reversal_rep_ref, t.reversal_at, t.refund_ref, t.refund_at, t.is_reconciled, t.reconciled_at, t.pending_approval, 
                t.service_id, t.rep_no, t.rep_version, t.rep_timestamp, t.param1, t.param2, t.param3, t.param4, t.param5, 
                t.cod_pool_acct_no, t.bill_date, t.due_date, t.bill_number, t.billpay_bank_ref]
      end
    end
  end

  def self.get_header
    ['App ID', 'Request No', 'Attempt No', 'Request Version', 'Request Timestamp', 'Customer ID', 'Debit Account No', 'Txn Kind', 
     'Txn Amount', 'Biller Code', 'Biller Account No', 'Bill ID', 'Status', 'Fault Code', 'Fault Reason', 'Debit Req Ref', 
     'Debit Attempt No', 'Debit Attempt At', 'Debit Rep Ref', 'Debited At', 'Billpay Req Ref', 'Billpay Attempt No', 
     'Billpay Attempt At', 'Billpay Rep Ref', 'Billpaid At', 'Reversal Req Ref', 'Reversal Attempt No', 'Reversal Attempt At',
     'Reversal Rep Ref', 'Reversal At', 'Refund Ref', 'Refund At', 'Is Reconciled', 'Reconciled At', 'Pending Approval', 
     'Service ID', 'Reply No', 'Reply Version', 'Reply Timestamp', 'Param1', 'Param2', 'Param3', 'Param4', 'Param5', 
     ' Cod Pool Account No', 'Bill Date', 'Due Date', 'Bill Number', 'Billpay Bank Ref']
  end
  
end