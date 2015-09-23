module EcolTransactionsHelper
  
  def find_ecol_transactions(transactions,params)
    ecol_transactions = transactions
    ecol_transactions = ecol_transactions.where("TRIM(transfer_unique_no)=?",params[:transfer_unique_no].strip) if params[:transfer_unique_no].present?
    ecol_transactions = ecol_transactions.where("customer_code=?",params[:customer_code]) if params[:customer_code].present?
    ecol_transactions = ecol_transactions.where("status=? and pending_approval=?",params[:status],params[:pending]) if params[:status].present? and params[:pending].present?
    ecol_transactions = ecol_transactions.where("pending_approval=?",params[:pending]) if params[:pending].present?
    ecol_transactions = ecol_transactions.where("status=?",params[:status]) if params[:status].present?
    ecol_transactions = ecol_transactions.where("notify_status=?",params[:notification_status]) if params[:notification_status].present?
    ecol_transactions = ecol_transactions.where("transfer_type=?",params[:transfer_type]) if params[:transfer_type].present? 
    ecol_transactions = ecol_transactions.where("bene_account_no=?",params[:bene_account_no]) if params[:bene_account_no].present?
    ecol_transactions = ecol_transactions.where("transfer_date>=? and transfer_date<=?",params[:from_transfer_date],params[:to_transfer_date]) if params[:to_transfer_date].present? and params[:from_transfer_date].present?
    ecol_transactions = ecol_transactions.where("transfer_amt>=? and transfer_amt<=?",params[:from_amount].to_f,params[:to_amount].to_f) if params[:to_amount].present? and params[:from_amount].present?
    ecol_transactions
  end
  
  def ecol_transaction_token_show(ecol_transaction, indx)
    unless ecol_transaction.ecol_customer.nil?
      token_types = ecol_transaction.ecol_customer.account_token_types
      case token_types[indx]
      when 'SC'
        token_value = ecol_transaction.customer_subcode
      when 'RC'
        token_value = ecol_transaction.remitter_code
        unless ecol_transaction.ecol_remitter.nil?
          link_to token_value, ecol_transaction.ecol_remitter
        else
          token_value
        end
      when 'IN'
        token_value = ecol_transaction.invoice_no
      end
    else
      "-"
    end
  end
  
  def txn_summary_count(status_hash,key) 
    count = status_hash[key] rescue 0 
    count.nil? ? 0 : count
  end
  
  def show_page_value_for_validation_status(ecol_transaction,value)
    value == "0" ? "SUCCESS" : ecol_transaction.validation_status
  end

  def pending_status(state)
    (state == 'CREDIT FAILED' or state == 'RETURN FAILED' or state == 'VALIDATION ERROR')
  end

  def find_pending_status(state)
    state.split(' ').first if (state == 'CREDIT FAILED' or state == 'RETURN FAILED' or state == 'VALIDATION ERROR')
  end

  def approval_status(state)
    (state == 'PENDING CREDIT' or state == 'PENDING RETURN')
  end

  def find_approval_status(state)
    state.split(' ').last if (state == 'PENDING CREDIT' or state == 'PENDING RETURN')
  end

  def find_logs(params,transaction)
    transaction.ecol_audit_logs.where('step_name=?',params[:step_name]).order("attempt_no desc") rescue []
  end
end
