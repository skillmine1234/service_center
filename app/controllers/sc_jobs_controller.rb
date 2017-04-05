class ScJobsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

  def index
    if request.get?
      @searcher = ScJobSearcher.new(params.permit(:approval_status, :page))
    else
      @searcher = ScJobSearcher.new(search_params)
    end
    @sc_jobs = @searcher.paginate
  end

  def show
    @sc_job = ScJob.find(params[:id])
  end
  
  def run
    sc_job = ScJob.find(params[:id])
    sc_job.run_now = 'Y'
    if sc_job.save
      flash[:alert] = 'Your job will start now!'
    else
      flash[:alert] = sc_job.errors.full_messages
    end
    redirect_to sc_jobs_path
  end
  
  def pause
    sc_job = ScJob.find(params[:id])
    sc_job.paused = 'Y'
    if sc_job.save
      flash[:alert] = 'Your job has been paused!'
    else
      flash[:alert] = sc_job.errors.full_messages
    end
    redirect_to sc_jobs_path
  end

  private

  def search_params
    params.permit(:page, :code)
  end
end
