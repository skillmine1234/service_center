module EcolTransactionsHelper
  
  def find_ecol_transactions(transactions,params)
    ecol_transactions = transactions
    ecol_transactions = ecol_transactions.where("transfer_unique_no=?",params[:transfer_unique_no]) if params[:transfer_unique_no].present?
    ecol_transactions = ecol_transactions.where("customer_code=?",params[:customer_code]) if params[:customer_code].present?
    ecol_transactions = ecol_transactions.where("status=?",params[:status]) if params[:status].present? 
    ecol_transactions = ecol_transactions.where("bene_account_no=?",params[:bene_account_no]) if params[:bene_account_no].present?
    ecol_transactions = ecol_transactions.where("transfer_date>=? and transfer_date<=?",params[:from_date],params[:to_date]) if params[:to_date].present? and params[:from_date].present?
    ecol_transactions = ecol_transactions.where("transfer_amt>=? and transfer_amt<=?",params[:from_amount].to_f,params[:to_amount].to_f) if params[:to_amount].present? and params[:from_amount].present?
    ecol_transactions
  end
end
