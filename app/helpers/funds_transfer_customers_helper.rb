module FundsTransferCustomersHelper
  def find_funds_transfer_customers(params)
    funds_transfer_customers = (params[:approval_status].present? and params[:approval_status] == 'U') ? FundsTransferCustomer.unscoped : FundsTransferCustomer
    funds_transfer_customers = funds_transfer_customers.where("name LIKE ?","#{params[:name].upcase}%") if params[:name].present?
    funds_transfer_customers = funds_transfer_customers.where("app_id=?",params[:app_id]) if params[:app_id].present?
    funds_transfer_customers
  end
end
