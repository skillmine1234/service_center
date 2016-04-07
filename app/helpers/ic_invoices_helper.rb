module IcInvoicesHelper
  def find_ic_invoices(params)
    ic_invoices = IcInvoice
    ic_invoices = ic_invoices.where("corp_customer_id=?",params[:corp_customer_id]) if params[:corp_customer_id].present?
    ic_invoices = ic_invoices.where("supplier_code=?",params[:supplier_code]) if params[:supplier_code].present?
    ic_invoices
  end
end
