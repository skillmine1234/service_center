class EcolAppUdtablesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include Approval2::ControllerAdditions
  
  def new
    @ecol_app_udtable = EcolAppUdtable.new
    @ecol_app_udtable.app_code = params[:app_code]
  end
  
  def create
    @ecol_app_udtable = EcolAppUdtable.new(params[:ecol_app_udtable])
    if !@ecol_app_udtable.valid?
      render "new"
    else
      @ecol_app_udtable.created_by = current_user.id
      @ecol_app_udtable.save!
      flash[:alert] = 'Ecol App Udf successfully created and is pending for approval'
      redirect_to @ecol_app_udtable
    end
  end
  
  def update
    @ecol_app_udtable = EcolAppUdtable.unscoped.find_by_id(params[:id])
    @ecol_app_udtable.attributes = params[:ecol_app_udtable]
    if !@ecol_app_udtable.valid?
      render "edit"
    else
      @ecol_app_udtable.updated_by = current_user.id
      @ecol_app_udtable.save!
      flash[:alert] = 'Ecol App Udf successfully modified and is pending for approval'
      redirect_to @ecol_app_udtable
    end
    rescue ActiveRecord::StaleObjectError
      @ecol_app_udtable.reload
      flash[:alert] = 'Someone edited the Ecol App Udf the same time you did. Please re-apply your changes to the Ecol App Udf.'
      render "edit"
  end
  
  def show
    @ecol_app_udtable = EcolAppUdtable.unscoped.find_by_id(params[:id])
  end

  def index
    @searcher = EcolAppUdtableSearcher.new(params.permit(:approval_status, :app_code, :page))
    @records = @searcher.paginate
  end
  
  def udfs
    @ecol_app = EcolApp.find_by(app_code: params[:app_code])
    respond_to do |format|
      format.js
    end
  end
  
  def audit_logs
    @ecol_app_udtable = EcolAppUdtable.unscoped.find(params[:id]) rescue nil
    @audit = @ecol_app_udtable.audits[params[:version_id].to_i] rescue nil
  end

  def approve
    redirect_to unapproved_records_path(group_name: 'e-collect')
  end

  private

  def ecol_app_udtable_params
    params.require(:ecol_app_udtable).permit(:app_code, :udf1, :udf2, :udf3, :udf4, :udf5, :created_by, :updated_by, :lock_version, 
    :approval_status, :last_action, :approved_version, :approved_id)
  end
end
