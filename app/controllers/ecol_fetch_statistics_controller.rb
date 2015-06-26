class EcolFetchStatisticsController < ApplicationController
  authorize_resource
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  
  def show
    @ecol_fetch_statistic = EcolFetchStatistic.find_by_id(params[:id])
  end
  
  def new
    @ecol_fetch_statistic = EcolFetchStatistic.new
  end
  
  def create
    @ecol_fetch_statistic = EcolFetchStatistic.new(params[:ecol_fetch_statistic])
    if !@ecol_fetch_statistic.valid?
      render "new"
    else
      @ecol_fetch_statistic.save
      flash[:alert] = 'successfully created'
      redirect_to @ecol_fetch_statistic
    end
  end
  
  def edit
    @ecol_fetch_statistic = EcolFetchStatistic.find_by_id(params[:id])
  end
  
  def update
    @ecol_fetch_statistic = EcolFetchStatistic.find_by_id(params[:id])
    @ecol_fetch_statistic.attributes = params[:ecol_fetch_statistic]
    if !@ecol_fetch_statistic.valid?
      render "edit"
    else
      @ecol_fetch_statistic.save
      flash[:alert] = 'successfully modified'
      redirect_to @ecol_fetch_statistic
    end
    rescue ActiveRecord::StaleObjectError
      @ecol_fetch_statistic.reload
      flash[:alert] = 'Someone edited the same time you did. Please re-apply your changes.'
      render "edit"
  end
  
  def index
    ecol_fetch_statistics = EcolFetchStatistic.order("id desc")
    @ecol_fetch_statistics_count = ecol_fetch_statistics.count
    @ecol_fetch_statistics = ecol_fetch_statistics.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
  
  private

  def ecol_fetch_statistic_params
    params.require(:ecol_fetch_statistic).permit(:last_neft_at, :last_neft_id, :last_neft_cnt, :tot_neft_cnt, :last_rtgs_at, 
    :last_rtgs_id, :last_rtgs_cnt, :tot_rtgs_cnt)
  end
  
end
