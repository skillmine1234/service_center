module BmBillPaymentHelper
  def find_bm_bill_payments(bm_bill_payment,params)
    bill_payments = bm_bill_payment
    bill_payments = bill_payments.where("bm_bill_payments.status=?",params[:status]) if params[:status].present?
    bill_payments = bill_payments.where("lower(bm_bill_payments.req_no) LIKE ?","%#{params[:request_no].downcase}%") if params[:request_no].present?
    bill_payments = bill_payments.where("bm_bill_payments.customer_id=?",params[:cust_id]) if params[:cust_id].present?
    bill_payments = bill_payments.where("bm_bill_payments.debit_account_no=?",params[:debit_no]) if params[:debit_no].present?
    bill_payments = bill_payments.where("bm_bill_payments.txn_kind=?",params[:txn_kind]) if params[:txn_kind].present?
    bill_payments = bill_payments.where("bm_bill_payments.txn_amount>=? and bm_bill_payments.txn_amount <=?",params[:from_amount].to_f,params[:to_amount].to_f) if params[:to_amount].present? and params[:from_amount].present?
    bill_payments = bill_payments.where("bm_bill_payments.biller_code=?",params[:biller_code]) if params[:biller_code].present?
    bill_payments = bill_payments.where("bm_bill_payments.biller_acct_no=?",params[:biller_acct_no]) if params[:biller_acct_no].present?
    bill_payments = bill_payments.where("bm_bill_payments.bill_id=?",params[:bill_id]) if params[:bill_id].present?
    bill_payments
  end
end