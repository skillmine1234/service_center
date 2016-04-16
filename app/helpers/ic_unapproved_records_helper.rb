module IcUnapprovedRecordsHelper
  def filter_records(records,params)
    result = []
    IcUnapprovedRecord::IC_TABLES.each do |record|
      records = IcUnapprovedRecord.where("ic_approvable_type =?",record)
      records = records.where("service_name =?",params[:sc_service]) if params[:sc_service].present?
      count = records.count  
      result << {:record_type => record, :record_count => count}
    end
    result
  end
end
