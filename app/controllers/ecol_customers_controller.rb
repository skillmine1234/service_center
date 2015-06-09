class EcolCustomersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include EcolCustomersHelper
  
  def new
    @ecol_customer = EcolCustomer.new
  end
  
  def create
    @ecol_customer = EcolCustomer.new(params[:ecol_customer])
    if !@ecol_customer.valid?
      render "new"
    else
      @ecol_customer.created_by = current_user.id
      @ecol_customer.save
      flash[:alert] = 'Customer successfuly created'
      redirect_to @ecol_customer
    end
  end
  
  def edit
    @ecol_customer = EcolCustomer.find_by_id(params[:id])
  end
  
  def update
    @ecol_customer = EcolCustomer.find_by_id(params[:id])
    @ecol_customer.attributes = params[:ecol_customer]
    if !@ecol_customer.valid?
      render "edit"
    else
      @ecol_customer.updated_by = current_user.id
      @ecol_customer.save
      flash[:alert] = 'Customer successfuly modified'
      redirect_to @ecol_customer
    end
    rescue ActiveRecord::StaleObjectError
      @ecol_customer.reload
      flash[:alert] = 'Someone edited the customer the same time you did. Please re-apply your changes to the customer.'
      render "edit"
  end
  
  def show
    @ecol_customer = EcolCustomer.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      ecol_customers = find_ecol_customers(params).order("id desc")
    else
      ecol_customers = EcolCustomer.order("id desc")
    end
    @ecol_customers_count = ecol_customers.count
    @ecol_customers = ecol_customers.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  def audit_logs
    @ecol_customer = EcolCustomer.find(params[:id]) rescue nil
    @audit = @ecol_customer.audits[params[:version_id].to_i] rescue nil
  end
  
  private

  def ecol_customer_params
    params.require(:ecol_customer).permit(:code, :name, :is_enabled, :val_method, :token_1_type, :token_1_length, :val_token_1, :token_2_type,
  :token_2_length, :val_token_2, :token_3_type, :token_3_length, :val_token_3, :val_txn_date, :val_txn_amt, :val_ben_name,
  :val_rem_acct, :return_if_val_fails, :file_upld_mthd, :credit_acct_no, :nrtv_sufx_1, :nrtv_sufx_2, :nrtv_sufx_3, :rmtr_alert_on,
  :rmtr_pass_txt, :rmtr_return_txt, :created_by, :updated_by, :lock_version)
  end
end
