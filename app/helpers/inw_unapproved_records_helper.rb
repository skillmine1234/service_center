module InwUnapprovedRecordsHelper
  def filter_records(records)
    result = []
    InwUnapprovedRecord::INW_TABLES.each do |record|
      count = InwUnapprovedRecord.where("inw_approvable_type =?",record).count 
      result << {:record_type => record, :record_count => count}
    end
    result
  end
end