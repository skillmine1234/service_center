class CsvExportsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :block_inactive_user!

  def index
    @csv_exports = CsvExport.where(:user_id => current_user.id, :group => params[:group]).order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    render :index
  end

  def download_csv
    csv_export = CsvExport.find(params[:csv_export])
    send_file csv_export.path, :type=>'text/pdf'
  end

end