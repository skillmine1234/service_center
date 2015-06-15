module EcolTransactionsHelper
  
  def find_ecol_transactions(params)
    ecol_transactions = EcolTransaction
    ecol_transactions = ecol_transactions.where("transfer_unique_no=?",params[:transfer_unique_no]) if params[:transfer_unique_no].present?
    ecol_transactions = ecol_transactions.where("customer_code=?",params[:customer_code]) if params[:customer_code].present? 
    ecol_transactions
  end
end
