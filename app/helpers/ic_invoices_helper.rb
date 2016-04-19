module IcInvoicesHelper
  include ApplicationHelper

  def find_ic_invoices(params)
    ic_invoices = IcInvoice
    ic_invoices = ic_invoices.where("corp_customer_id=?",params[:corp_customer_id]) if params[:corp_customer_id].present?
    ic_invoices = ic_invoices.where("supplier_code=?",params[:supplier_code]) if params[:supplier_code].present?
    ic_invoices = ic_invoices.where("invoice_no=?",params[:invoice_no]) if params[:invoice_no].present?
    ic_invoices = ic_invoices.where("invoice_date>=?",DateTime.parse(params[:from_date]).in_time_zone.beginning_of_day) if params[:from_date].present? and valid_date(params[:from_date])
    ic_invoices = ic_invoices.where("invoice_date<=?",DateTime.parse(params[:to_date]).in_time_zone.end_of_day) if params[:to_date].present? and valid_date(params[:to_date])
    ic_invoices = ic_invoices.where("invoice_due_date>=?",DateTime.parse(params[:invoice_from_due_date]).in_time_zone.beginning_of_day) if params[:invoice_from_due_date].present? and valid_date(params[:invoice_from_due_date])
    ic_invoices = ic_invoices.where("invoice_due_date<=?",DateTime.parse(params[:invoice_to_due_date]).in_time_zone.end_of_day) if params[:invoice_to_due_date].present? and valid_date(params[:invoice_to_due_date])
    ic_invoices = ic_invoices.where("invoice_amount>=?", params[:from_amount].to_f) if params[:from_amount].present?
    ic_invoices = ic_invoices.where("invoice_amount<=?", params[:to_amount].to_f) if params[:to_amount].present?
    ic_invoices = ic_invoices.where("credit_ref_no=?",params[:credit_ref_no]) if params[:credit_ref_no].present?
    ic_invoices = ic_invoices.where("repaid_amount>=?",params[:repaid_from_amount].to_f) if params[:repaid_from_amount].present?
    ic_invoices = ic_invoices.where("repaid_amount<=?",params[:repaid_to_amount].to_f) if params[:repaid_to_amount].present?
    ic_invoices = ic_invoices.where("repayment_date>=?",DateTime.parse(params[:repayment_from_date]).in_time_zone.beginning_of_day) if params[:repayment_from_date].present? and valid_date(params[:repayment_from_date]) 
    ic_invoices = ic_invoices.where("repayment_date<=?",DateTime.parse(params[:repayment_to_date]).in_time_zone.end_of_day) if params[:repayment_to_date].present? and valid_date(params[:repayment_to_date])
    ic_invoices
  end
end