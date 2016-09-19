class ReconciledReturnsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include ReconciledReturnsHelper
  
  def index
    reconciled_returns = ReconciledReturn.order("id desc")
    if params[:advanced_search].present? || params[:summary].present?
      reconciled_returns = find_reconciled_returns(params).order("id desc")
    end
    @reconciled_returns_count = reconciled_returns.count(:id)
    @reconciled_returns = reconciled_returns.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  def show
    @reconciled_return = ReconciledReturn.find_by_id(params[:id])
  end

  def new
    @reconciled_return = ReconciledReturn.new
  end

  def create
    @reconciled_return = ReconciledReturn.new(params[:reconciled_return])
    if !@reconciled_return.valid?
      render "new"
    else
      @reconciled_return.created_by = current_user.id
      @reconciled_return.save
      flash[:alert] = 'Reconciled Return successfully created.'
      redirect_to @reconciled_return
    end
  end

  def audit_logs
    @reconciled_return = ReconciledReturn.find(params[:id]) rescue nil
    @audit = @reconciled_return.audits[params[:version_id].to_i] rescue nil
  end

  private

  def reconciled_return_params
    params.require(:reconciled_return).permit(:txn_type, :return_code, :settlement_date, :bank_ref_no, :reason, 
                   :created_by, :updated_by, :updated_by, :last_action)
  end

end
