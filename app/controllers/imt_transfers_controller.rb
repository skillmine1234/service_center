class ImtTransfersController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include ImtTransfersHelper
  
  def index
    imt_transfers = ImtTransfer.order("id desc")
    if params[:advanced_search].present? || params[:summary].present?
      imt_transfers = find_imt_transfers(params).order("id desc")
    end
    @imt_transfers_count = imt_transfers.count(:id)
    @imt_transfers = imt_transfers.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  def show
    @imt_transfer = ImtTransfer.find_by_id(params[:id])
  end
end
