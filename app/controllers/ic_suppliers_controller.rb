class IcSuppliersController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include IcSuppliersHelper
  
  def new
    @ic_supplier = IcSupplier.new
  end

  def create
    @ic_supplier = IcSupplier.new(params[:ic_supplier])
    if !@ic_supplier.valid?
      render "new"
    else
      @ic_supplier.created_by = current_user.id
      @ic_supplier.save!
      flash[:alert] = "Instant Credit Supplier successfully #{@ic_supplier.approved_id.nil? ? 'created' : 'updated'} and is pending for approval"
      redirect_to @ic_supplier
    end
  end 

  def edit
    ic_supplier = IcSupplier.unscoped.find_by_id(params[:id])
    if ic_supplier.approval_status == 'A' && ic_supplier.unapproved_record.nil?
      params = (ic_supplier.attributes).merge({:approved_id => ic_supplier.id, :approved_version => ic_supplier.lock_version})
      ic_supplier = IcSupplier.new(params)
    end
    @ic_supplier = ic_supplier
  end

  def update
    @ic_supplier = IcSupplier.unscoped.find_by_id(params[:id])
    @ic_supplier.attributes = params[:ic_supplier]
    if !@ic_supplier.valid?
      render "edit"
    else
      @ic_supplier.updated_by = current_user.id
      @ic_supplier.save!
      flash[:alert] = 'Instant Credit Supplier successfully modified and is pending for approval'
      redirect_to @ic_supplier
    end
    rescue ActiveRecord::StaleObjectError
      @ic_supplier.reload
      flash[:alert] = 'Someone edited the Instant Credit Supplier the same time you did. Please re-apply your changes to the Instant Credit Supplier'
      render "edit"
  end 

  def show
    @ic_supplier = IcSupplier.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      ic_suppliers = find_ic_suppliers(params).order("id desc")
    else
      ic_suppliers = (params[:approval_status].present? and params[:approval_status] == 'U') ? IcSupplier.unscoped.where("approval_status =?",'U').order("id desc") : IcSupplier.order("id desc")
    end
    @ic_suppliers_count = ic_suppliers.count
    @ic_suppliers = ic_suppliers.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @ic_supplier = IcSupplier.unscoped.find(params[:id]) rescue nil
    @audit = @ic_supplier.audits[params[:version_id].to_i] rescue nil
  end

  def approve
    @ic_supplier = IcSupplier.unscoped.find(params[:id]) rescue nil
    IcSupplier.transaction do
      approval = @ic_supplier.approve
      if @ic_supplier.save and approval.empty?
        flash[:alert] = "Instant Credit Supplier record was approved successfully"
      else
        msg = approval.empty? ? @ic_supplier.errors.full_messages : @ic_supplier.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @ic_supplier
  end

  private

  def ic_supplier_params
    params.require(:ic_supplier).permit(:supplier_code, :supplier_name, :customer_id, :od_account_no, :ca_account_no, :is_enabled, 
                                        :created_by, :updated_by, :created_at, :updated_at, :lock_version, 
                                        :approval_status, :last_action, :approved_version, :approved_id, :corp_customer_id)
  end
end
