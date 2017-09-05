class SspBanksController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include Approval2::ControllerAdditions
  include ApplicationHelper

  def new
    @ssp_bank = SspBank.new
  end

  def create
    @ssp_bank = SspBank.new(ssp_bank_params)
    if !@ssp_bank.valid?
      render "new"
    else
      @ssp_bank.created_by = current_user.id
      @ssp_bank.save!
      flash[:alert] = 'SimSePay Bank successfully created and is pending for approval'
      redirect_to @ssp_bank
    end
  end

  def update
    @ssp_bank = SspBank.unscoped.find_by_id(params[:id])
    @ssp_bank.attributes = params[:ssp_bank]
    if !@ssp_bank.valid?
      render "edit"
    else
      @ssp_bank.updated_by = current_user.id
      @ssp_bank.save!
      flash[:alert] = 'SimSePay Bank successfully modified successfully'
      redirect_to @ssp_bank
    end
    rescue ActiveRecord::StaleObjectError
      @ssp_bank.reload
      flash[:alert] = 'Someone edited the SimSePay Bank the same time you did. Please re-apply your changes to the SimSePay Bank'
      render "edit"
  end 

  def show
    @ssp_bank = SspBank.unscoped.find_by_id(params[:id])
  end

  def index
    if request.get?
      @searcher = SspBankSearcher.new(params.permit(:page, :approval_status))
    else
      @searcher = SspBankSearcher.new(search_params)
    end
    @records = @searcher.paginate
  end

  def audit_logs
    @record = SspBank.unscoped.find(params[:id]) rescue nil
    @audit = @record.audits[params[:version_id].to_i] rescue nil
  end

  def approve
    redirect_to unapproved_records_path(group_name: 'ssp')
  end

  private

  def ssp_bank_params
    params.require(:ssp_bank).permit(:customer_code, :debit_account_url, :reverse_debit_account_url,
    :get_status_url, :get_account_status_url, :app_code, :settings_cnt, :user_proxy,
    :lock_version, :last_action, :updated_by, 
    :http_username, :http_password, :approval_status, :approved_version, :approved_id,
    :setting1_name, :setting1_type, :setting1_value, 
    :setting2_name, :setting2_type, :setting2_value, 
    :setting3_name, :setting3_type, :setting3_value, 
    :setting4_name, :setting4_type, :setting4_value,
    :setting5_name, :setting5_type, :setting5_value
    )
  end
  
  def search_params
    params.permit(:page, :approval_status, :app_code, :customer_code)
  end
  
end