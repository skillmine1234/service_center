module ReconciledReturnsHelper
  def find_reconciled_returns(params)
    reconciled_returns = ReconciledReturn
    reconciled_returns = reconciled_returns.where("bank_ref_no=?", params[:bank_ref_no].upcase) if params[:bank_ref_no].present?
    reconciled_returns
  end
end
