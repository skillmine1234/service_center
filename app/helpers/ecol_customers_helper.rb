module EcolCustomersHelper
  
  def show_page_value_for_account_tokens(value)
    if (value == "N")
      "None"
    elsif (value == "SC")
      "Sub Code"
    elsif (value == "RC")
      "Remitter Code"
    elsif (value == "IN")
      "Invoice Number"
    end
  end
  
  def show_page_value_for_val_method(value)
    if (value == "N")
      "None"
    elsif (value == "W")
      "Web Service"
    elsif (value == "D")
      "Database Lookup"
    end
  end
  
  def find_ecol_customers(params)
    ecol_customers = (params[:approval_status].present? and params[:approval_status] == 'U') ? EcolCustomer.unscoped : EcolCustomer
    ecol_customers = ecol_customers.where("approval_status=?",params[:approval_status]) if params[:approval_status].present?
    ecol_customers = ecol_customers.where("code=?",params[:code]) if params[:code].present?
    ecol_customers = ecol_customers.where("is_enabled=?",params[:is_enabled]) if params[:is_enabled].present?
    ecol_customers = ecol_customers.where("credit_acct_no=?",params[:credit_acct_no]) if params[:credit_acct_no].present?
    ecol_customers
  end

end
