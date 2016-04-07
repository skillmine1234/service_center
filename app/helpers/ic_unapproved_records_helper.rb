module IcUnapprovedRecordsHelper
  def filter_records(records)
    result = []
    IcUnapprovedRecord::IC_TABLES.each do |record|
      count = IcUnapprovedRecord.where("ic_approvable_type =?",record).count 
      result << {:record_type => record, :record_count => count}
    end
    result
  end
end
