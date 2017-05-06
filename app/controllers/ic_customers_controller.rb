class IcCustomersController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include IcCustomersHelper
  
  def new
    @ic_customer = IcCustomer.new
  end

  def create
    @ic_customer = IcCustomer.new(params[:ic_customer])
    if !@ic_customer.valid?
      render "new"
    else
      @ic_customer.created_by = current_user.id
      @ic_customer.save!
      flash[:alert] = "Instant Credit Customer successfully #{@ic_customer.approved_id.nil? ? 'created' : 'updated'} and is pending for approval"
      redirect_to @ic_customer
    end
  end 

  def edit
    ic_customer = IcCustomer.unscoped.find_by_id(params[:id])
    if ic_customer.approval_status == 'A' && ic_customer.unapproved_record.nil?
      params = (ic_customer.attributes).merge({:approved_id => ic_customer.id, :approved_version => ic_customer.lock_version})
      ic_customer = IcCustomer.new(params)
    end
    @ic_customer = ic_customer
  end

  def update
    @ic_customer = IcCustomer.unscoped.find_by_id(params[:id])
    @ic_customer.attributes = params[:ic_customer]
    if !@ic_customer.valid?
      render "edit"
    else
      @ic_customer.updated_by = current_user.id
      @ic_customer.save!
      flash[:alert] = 'Instant Credit Customer successfully modified and is pending for approval'
      redirect_to @ic_customer
    end
    rescue ActiveRecord::StaleObjectError
      @ic_customer.reload
      flash[:alert] = 'Someone edited the Instant Credit Customer the same time you did. Please re-apply your changes to the Instant Credit Customer'
      render "edit"
  end 

  def show
    @ic_customer = IcCustomer.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      ic_customers = find_ic_customers(params).order("id desc")
    else
      ic_customers = (params[:approval_status].present? and params[:approval_status] == 'U') ? IcCustomer.unscoped.where("approval_status =?",'U').order("id desc") : IcCustomer.order("id desc")
    end
    @ic_customers_count = ic_customers.count
    @ic_customers = ic_customers.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @ic_customer = IcCustomer.unscoped.find(params[:id]) rescue nil
    @audit = @ic_customer.audits[params[:version_id].to_i] rescue nil
  end

  def approve
    @ic_customer = IcCustomer.unscoped.find(params[:id]) rescue nil
    IcCustomer.transaction do
      approval = @ic_customer.approve
      if @ic_customer.save and approval.empty?
        flash[:alert] = "Instant Credit Customer record was approved successfully"
      else
        msg = approval.empty? ? @ic_customer.errors.full_messages : @ic_customer.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @ic_customer
  end

  private

  def ic_customer_params
    params.require(:ic_customer).permit(:customer_id, :app_id, :identity_user_id, :repay_account_no, :fee_pct, :fee_income_gl, 
                                        :max_overdue_pct, :cust_contact_email, :cust_contact_mobile, :ops_email, :rm_email, 
                                        :is_enabled, :created_by, :updated_by, :created_at, :updated_at, :lock_version, 
                                        :approval_status, :last_action, :approved_version, :approved_id, :customer_name, :sc_backend_code)
  end
end
