module IcCustomersHelper
  def find_ic_customers(params)
    ic_customers = (params[:approval_status].present? and params[:approval_status] == 'U') ? IcCustomer.unscoped : IcCustomer
    ic_customers = ic_customers.where("customer_id=?",params[:customer_id]) if params[:customer_id].present?
    ic_customers = ic_customers.where("app_id=?",params[:app_id]) if params[:app_id].present?
    ic_customers = ic_customers.where("identity_user_id=?",params[:identity_user_id]) if params[:identity_user_id].present?
    ic_customers = ic_customers.where("repay_account_no=?",params[:repay_account_no]) if params[:repay_account_no].present?
    ic_customers = ic_customers.where("fee_pct=?",params[:fee_pct]) if params[:fee_pct].present?
    ic_customers = ic_customers.where("fee_income_gl=?",params[:fee_income_gl]) if params[:fee_income_gl].present?
    ic_customers
  end
end
