module ImtCustomersHelper
  def find_imt_customers(params)
    imt_customers = (params[:approval_status].present? and params[:approval_status] == 'U') ? ImtCustomer.unscoped : ImtCustomer
    imt_customers = imt_customers.where("customer_code=?",params[:customer_code]) if params[:customer_code].present?
    imt_customers = imt_customers.where("customer_name=?",params[:customer_name]) if params[:customer_name].present?
    imt_customers = imt_customers.where("account_no=?",params[:account_no]) if params[:account_no].present?
    imt_customers
  end
  
  def show_page_value_for_txn_mode(value)
    case value
    when "F"
      "File"
    when "A"
      "Api"
    end
  end
end
