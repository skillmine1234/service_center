module SmBankAccountsHelper
  def find_sm_bank_accounts(params)
    sm_bank_accounts = (params[:approval_status].present? and params[:approval_status] == 'U') ? SmBankAccount.unscoped : SmBankAccount
    sm_bank_accounts = sm_bank_accounts.where("sm_code = ?", params[:sm_code].downcase) if params[:sm_code].present?
    sm_bank_accounts = sm_bank_accounts.where("is_enabled=?",params[:is_enabled]) if params[:is_enabled].present?
    sm_bank_accounts = sm_bank_accounts.where("customer_id = ?", params[:customer_id]) if params[:customer_id].present?
    sm_bank_accounts = sm_bank_accounts.where("account_no = ?", params[:account_no].downcase) if params[:account_no].present?
    sm_bank_accounts
  end
end
