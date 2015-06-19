class EcolTransactionsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include EcolTransactionsHelper
  
  def index
    if params[:advanced_search].present?
      ecol_transactions = find_ecol_transactions(params).order("id desc")
    else
      ecol_transactions = EcolTransaction.order("id desc")
    end
    @ecol_transactions_count = ecol_transactions.count
    @ecol_transactions = ecol_transactions.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  def show
    @ecol_transaction = EcolTransaction.find_by_id(params[:id])
  end
  
  private

  def ecol_transaction_params
    params.require(:ecol_transaction).permit(:status, :transfer_type, :transfer_unique_no, :transfer_status, 
    :transfer_date, :transfer_ccy, :transfer_amt, :rmtr_ref, :rmtr_full_name, :rmtr_address, :rmtr_account_type, :rmtr_account_no,
    :rmtr_account_ifsc, :bene_full_name, :bene_account_type, :bene_account_no, :bene_account_ifsc, :rmtr_to_bene_note, :received_at, :tokenized_at,
    :tokenzation_status, :customer_code, :customer_subcode, :remitter_code, :validated_at, :vaidation_status,
    :credited_at, :credit_status, :credit_ref, :credit_attempt_no, :rmtr_email_notify_ref, :rmtr_sms_notify_ref,
    :settled_at, :settle_status, :settle_ref, :settle_attempt_no, :fault_at, :fault_code, :fault_reason, :created_at,
    :updated_at)
  end
  
end
