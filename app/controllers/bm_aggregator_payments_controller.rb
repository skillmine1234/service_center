class BmAggregatorPaymentsController < ApplicationController
  # authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include BmAggregatorPaymentsHelper
  
  def new
    @bm_aggregator_payment = BmAggregatorPayment.new
  end

  def create
    @bm_aggregator_payment = BmAggregatorPayment.new(params[:bm_aggregator_payment])
    if !@bm_aggregator_payment.valid?
      render "new"
    else
      @bm_aggregator_payment.save!

      flash[:alert] = 'Aggregator Payment successfully created and is pending for approval'
      redirect_to @bm_aggregator_payment
    end
  end 

  def edit
    bm_aggregator_payment = BmAggregatorPayment.unscoped.find_by_id(params[:id])
    if bm_aggregator_payment.approval_status == 'A' && bm_aggregator_payment.unapproved_record.nil?
      params = (bm_aggregator_payment.attributes).merge({:approved_id => bm_aggregator_payment.id,:approved_version => bm_aggregator_payment.lock_version})
      bm_aggregator_payment = BmAggregatorPayment.new(params)
    end
    @bm_aggregator_payment = bm_aggregator_payment   
  end

  def update
    @bm_aggregator_payment = BmAggregatorPayment.unscoped.find_by_id(params[:id])
    @bm_aggregator_payment.attributes = params[:bm_aggregator_payment]
    if !@bm_aggregator_payment.valid?
      render "edit"
    else
      @bm_aggregator_payment.save!
      flash[:alert] = 'Aggregator Payment successfully modified and is pending for approval'
      redirect_to @bm_aggregator_payment
    end
    rescue ActiveRecord::StaleObjectError
      @bm_aggregator_payment.reload
      flash[:alert] = 'Someone edited the aggregator payment the same time you did. Please re-apply your changes to the aggregator payment.'
      render "edit"
  end 

  def show
    @bm_aggregator_payment = BmAggregatorPayment.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      bm_aggregator_payments = find_bm_aggregator_payments(params).order("id desc")
    else
      bm_aggregator_payments = (params[:approval_status].present? and params[:approval_status] == 'U') ? BmAggregatorPayment.unscoped.where("approval_status =?",'U').order("id desc") : BmAggregatorPayment.order("id desc")
    end
    @bm_aggregator_payments_count = bm_aggregator_payments.count
    @bm_aggregator_payments = bm_aggregator_payments.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @bm_aggregator_payment = BmAggregatorPayment.unscoped.find(params[:id]) rescue nil
    @audit = @bm_aggregator_payment.audits[params[:version_id].to_i] rescue nil
  end
  
  def approve
    @bm_biller = BmAggregatorPayment.unscoped.find(params[:id]) rescue nil
    BmAggregatorPayment.transaction do
      approval = @bm_biller.approve
      if @bm_biller.save and approval.empty?
        flash[:alert] = "BmAggregatorPayment record was approved successfully"
      else
        msg = approval.empty? ? @bm_biller.errors.full_messages : @bm_biller.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @bm_biller
  end
  
  private

  def bm_aggregator_payment_params
    params.require(:bm_aggregator_payment).permit(:cod_acct_no, :neft_sender_ifsc, :bene_acct_no, :bene_acct_ifsc, :payment_amount, 
                                                  :bank_ref, :lock_version, :approval_status, :last_action, :approved_version, 
                                                  :approved_id, :status, :fault_code, :fault_reason, :neft_req_ref, :neft_attempt_no, 
                                                  :neft_attemp_at, :neft_rep_ref, :neft_completed_at)
  end
end
