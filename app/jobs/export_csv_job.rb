class ExportCsvJob < ActiveJob::Base
  queue_as :default

  def perform(className, csv_path, params, delayed_job_result)
    delayed_job_result.update_attributes(:executed_at => Time.now, :path => csv_path)
    className.constantize.to_csv(csv_path, params)
    delayed_job_result.update_attributes(:state => 'completed')
  end
end
