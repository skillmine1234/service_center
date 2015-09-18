class EcolTransactionsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include EcolTransactionsHelper
  
  def index
    ecol_transactions = EcolTransaction.order("id desc")
    if params[:advanced_search].present? || params[:summary].present?
      ecol_transactions = find_ecol_transactions(ecol_transactions,params).order("id desc")
    end
    @ecol_transactions_count = ecol_transactions.count
    @ecol_transactions = ecol_transactions.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  def show
    @ecol_transaction = EcolTransaction.find_by_id(params[:id])
  end
  
  def summary 
    ecol_transactions = EcolTransaction.order("id desc")
    @ecol_transaction_summary = EcolTransaction.group(:status, :pending_approval).count
    @ecol_transaction_statuses = EcolTransaction.group(:status).count.keys
    @total_pending_records = EcolTransaction.where(:pending_approval => 'Y').count
    @total_records = EcolTransaction.count
  end
  
  def edit_multiple
    if params[:ecol_transaction_ids]
      @ecol_transactions = EcolTransaction.find(params[:ecol_transaction_ids])
    else
      flash[:notice] = "You haven't selected any transaction records!"
      redirect_to ecol_transactions_path
    end
  end

  def update_multiple
    @ecol_transactions = EcolTransaction.find(params[:ecol_transaction_ids])
    @ecol_transactions.each do |ecol_transaction|
      ecol_transaction.update_attributes(:pending_approval => "N")
    end
    flash[:notice] = "Updated transactions!"
    redirect_to ecol_transactions_path
  end

  def ecol_validations
    @ecol_transaction = EcolTransaction.find(params[:id])
    @ecol_validations = @ecol_transaction.ecol_validations rescue []
  end

  def ecol_notifications
    @ecol_transaction = EcolTransaction.find(params[:id])
    @ecol_notifications = @ecol_transaction.ecol_notifications rescue []
  end
  
  private

  def ecol_transaction_params
    params.require(:ecol_transaction).permit(:status, :transfer_type, :transfer_unique_no, :transfer_status, 
    :transfer_date, :transfer_ccy, :transfer_amt, :rmtr_ref, :rmtr_full_name, :rmtr_address, :rmtr_account_type, :rmtr_account_no,
    :rmtr_account_ifsc, :bene_full_name, :bene_account_type, :bene_account_no, :bene_account_ifsc, :rmtr_to_bene_note, :received_at, :tokenized_at,
    :tokenzation_status, :customer_code, :customer_subcode, :remitter_code, :validated_at, :vaidation_status,
    :credited_at, :credit_status, :credit_ref, :credit_attempt_no, :rmtr_email_notify_ref, :rmtr_sms_notify_ref,
    :settled_at, :settle_status, :settle_ref, :settle_attempt_no, :fault_at, :fault_code, :fault_reason, :created_at,
    :updated_at, :ecol_remitter_id, :pending_approval)
  end
  
end
