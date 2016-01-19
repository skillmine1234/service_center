class CsvExport < ActiveRecord::Base
  belongs_to :user

  def execution_time
    seconds = updated_at - created_at
    Time.at(seconds).gmtime.strftime('%R:%S')
  end

  def elapsed_time
    if state == 'in_progress'
      seconds = Time.zone.now - created_at
      Time.at(seconds).gmtime.strftime('%R:%S')
    else
      seconds = updated_at - created_at
      Time.at(seconds).gmtime.strftime('%R:%S')
    end
  end

  def execution_time_more_than_30?
    seconds = updated_at - created_at
    seconds > 30
  end
  
  def base_path
    Rails.root.join('public', "#{ENV['CONFIG_DOWNLOAD_PATH']}", "#{id}_#{request_type}")
  end
  
  def csv_path
    "#{base_path}.csv"
  end
end
