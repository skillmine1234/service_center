module FtCustomerAccountsHelper
  def find_ft_customer_accounts(params)
    ft_customer_accounts = (params[:approval_status].present? and params[:approval_status] == 'U') ? FtCustomerAccount.unscoped : FtCustomerAccount
    ft_customer_accounts = ft_customer_accounts.where("customer_id=?",params[:customer_id]) if params[:customer_id].present?
    ft_customer_accounts
  end

  def ft_customers_for_select
    FundsTransferCustomer.all.collect { |m| [m.customer_id, m.customer_id] }
  end
end
