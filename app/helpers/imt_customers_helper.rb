module ImtCustomersHelper
  def find_imt_customers(imt_customer,params)
    imt_customers = imt_customer
    imt_customers = imt_customers.where("customer_code=?",params[:customer_code]) if params[:customer_code].present?
    imt_customers = imt_customers.where("customer_name=?",params[:customer_name]) if params[:customer_name].present?
    imt_customers = imt_customers.where("account_no=?",params[:account_no]) if params[:account_no].present?
    imt_customers
  end
end
