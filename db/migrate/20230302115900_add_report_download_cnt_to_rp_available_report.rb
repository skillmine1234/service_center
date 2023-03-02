class AddReportDownloadCntToRpAvailableReport < ActiveRecord::Migration
  def change
    add_column :rp_available_reports, :report_download_cnt, :integer,default: 0
  end
end
