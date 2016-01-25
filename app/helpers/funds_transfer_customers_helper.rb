module FundsTransferCustomersHelper
  def find_funds_transfer_customers(params)
    funds_transfer_customers = (params[:approval_status].present? and params[:approval_status] == 'U') ? FundsTransferCustomer.unscoped : FundsTransferCustomer
    funds_transfer_customers = funds_transfer_customers.where("name LIKE ?","#{params[:name].upcase}%") if params[:name].present?
    funds_transfer_customers = funds_transfer_customers.where("tech_email_id=?",params[:tech_email_id]) if params[:tech_email_id].present?
    funds_transfer_customers = funds_transfer_customers.where("mobile_no=?",params[:mobile_no]) if params[:mobile_no].present?
    funds_transfer_customers = funds_transfer_customers.where("account_no=?",params[:account_no].upcase) if params[:account_no].present?
    funds_transfer_customers
  end
end
