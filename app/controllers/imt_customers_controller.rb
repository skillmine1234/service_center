class ImtCustomersController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include ImtCustomersHelper
  
  def new
    @imt_customer = ImtCustomer.new
  end

  def create
    @imt_customer = ImtCustomer.new(params[:imt_customer])
    if !@imt_customer.valid?
      render "new"
    else
      @imt_customer.created_by = current_user.id
      @imt_customer.save!
      flash[:alert] = "Customer successfully #{@imt_customer.approved_id.nil? ? 'created' : 'updated'} and is pending for approval"
      redirect_to @imt_customer
    end
  end 

  def edit
    imt_customer = ImtCustomer.unscoped.find_by_id(params[:id])
    if imt_customer.approval_status == 'A' && imt_customer.unapproved_record.nil?
      params = (imt_customer.attributes).merge({:approved_id => imt_customer.id,:approved_version => imt_customer.lock_version})
      imt_customer = ImtCustomer.new(params)
    end
    @imt_customer = imt_customer   
  end

  def update
    @imt_customer = ImtCustomer.unscoped.find_by_id(params[:id])
    @imt_customer.attributes = params[:imt_customer]
    if !@imt_customer.valid?
      render "edit"
    else
      @imt_customer.updated_by = current_user.id
      @imt_customer.save!
      flash[:alert] = 'Customer successfully modified and is pending for approval'
      redirect_to @imt_customer
    end
    rescue ActiveRecord::StaleObjectError
      @imt_customer.reload
      flash[:alert] = 'Someone edited the Customer the same time you did. Please re-apply your changes to the Customer.'
      render "edit"
  end 

  def show
    @imt_customer = ImtCustomer.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      imt_customers = find_imt_customers(params).order("id desc")
    else
      imt_customers = (params[:approval_status].present? and params[:approval_status] == 'U') ? ImtCustomer.unscoped.where("approval_status =?",'U').order("id desc") : ImtCustomer.order("id desc")
    end
    @imt_customers_count = imt_customers.count
    @imt_customers = imt_customers.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @imt_customer = ImtCustomer.unscoped.find(params[:id]) rescue nil
    @audit = @imt_customer.audits[params[:version_id].to_i] rescue nil
  end
  
  def approve
    @imt_customer = ImtCustomer.unscoped.find(params[:id]) rescue nil
    ImtCustomer.transaction do
      approval = @imt_customer.approve
      if @imt_customer.save and approval.empty?
        flash[:alert] = "Customer record was approved successfully"
      else
        msg = approval.empty? ? @imt_customer.errors.full_messages : @imt_customer.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @imt_customer
  end

  private

  def imt_customer_params
    params.require(:imt_customer).permit(:customer_code, :customer_name, :contact_person, :email_id, :mobile_no, 
                                         :account_no, :expiry_period, :txn_mode, :address_line1, :is_enabled,
                                         :address_line2, :address_line3, :country, :lock_version, :approval_status, 
                                         :last_action, :approved_version, :approved_id, :created_by, :updated_by, :app_id)
  end
end
