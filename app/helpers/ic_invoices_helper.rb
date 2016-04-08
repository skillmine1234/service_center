module IcInvoicesHelper
  def find_ic_invoices(params)
    ic_invoices = IcInvoice
    ic_invoices = ic_invoices.where("corp_customer_id=?",params[:corp_customer_id]) if params[:corp_customer_id].present?
    ic_invoices = ic_invoices.where("supplier_code=?",params[:supplier_code]) if params[:supplier_code].present?
    ic_invoices = ic_invoices.where("invoice_no=?",params[:invoice_no]) if params[:invoice_no].present?
    ic_invoices = ic_invoices.where("invoice_amount>=? and invoice_amount<=?",params[:from_amount].to_f,params[:to_amount].to_f) if params[:to_amount].present? and params[:from_amount].present?
    ic_invoices = ic_invoices.where("invoice_date>=? and invoice_date<=?",Time.zone.parse(params[:from_date]).beginning_of_day,Time.zone.parse(params[:to_date]).end_of_day) if params[:from_date].present? and params[:to_date].present?
    ic_invoices = ic_invoices.where("credit_ref_no=?",params[:credit_ref_no]) if params[:credit_ref_no].present?
    ic_invoices = ic_invoices.where("repayment_ref_no=?",params[:repayment_ref_no]) if params[:repayment_ref_no].present?
    ic_invoices
  end
end
