module ScUnapprovedRecordsHelper
  def filter_records(records,params)
    result = []
    ScUnapprovedRecord::SC_TABLES.each do |record|
      records = ScUnapprovedRecord.where("sc_approvable_type =?",record)
      records = records.where("service_name =?",params[:sc_service]) if params[:sc_service].present?
      count = records.count  
      result << {:record_type => record, :record_count => count}
    end
    result
  end
end
