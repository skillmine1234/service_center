class IcInvoicesController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include IcInvoicesHelper
  
  def index
    ic_invoices = IcInvoice.order("id desc")
    if params[:advanced_search].present?
      ic_invoices = find_ic_invoices(params).order("id desc")
    end
    @ic_invoices_count = ic_invoices.count(:id)
    @ic_invoices = ic_invoices.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  def show
    @ic_invoice = IcInvoice.find_by_id(params[:id])
  end
end
