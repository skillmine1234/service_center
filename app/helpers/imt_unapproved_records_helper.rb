module ImtUnapprovedRecordsHelper
  def filter_records(records)
    result = []
    ImtUnapprovedRecord::IMT_TABLES.each do |record|
      count = ImtUnapprovedRecord.where("imt_approvable_type =?",record).count 
      result << {:record_type => record, :record_count => count}
    end
    result
  end
end
