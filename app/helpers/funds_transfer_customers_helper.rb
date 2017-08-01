module FundsTransferCustomersHelper
  def find_funds_transfer_customers(params)
    funds_transfer_customers = (params[:approval_status].present? and params[:approval_status] == 'U') ? FundsTransferCustomer.unscoped : FundsTransferCustomer
    funds_transfer_customers = funds_transfer_customers.where("name LIKE ?","#{params[:name].upcase}%") if params[:name].present?
    funds_transfer_customers = funds_transfer_customers.where("app_id=?",params[:app_id]) if params[:app_id].present?
    funds_transfer_customers
  end
  
  def get_allowed_relns(ft_customer)
    if ft_customer.allowed_relns.empty?
      if ft_customer.is_retail == 'Y'
        return "GUR, JOF, JOO, SOW, TRU"
      else
        return "GUR, JOF, JOO, SOW, TRU, AUS"
      end
    else
      return ft_customer.allowed_relns.join(', ')
    end
  end
end
