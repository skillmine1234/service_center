class SspAuditStepsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  
  def index
    if request.get?
      @searcher = SspAuditStepSearcher.new(params.permit(:page))
    else
      @searcher = SspAuditStepSearcher.new(search_params)
    end
    @records = @searcher.paginate
  end
  
  def show
    @audit_step = SspAuditStep.find_by_id(params[:id])
  end
  
  private

  def search_params
    params.permit(:page, :app_code, :customer_code, :step_name, :status_code, :from_request_timestamp, :to_request_timestamp, :from_reply_timestamp, :to_reply_timestamp)
  end
end