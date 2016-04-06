module Pc2UnapprovedRecordsHelper
  def filter_records(records)
    result = []
    Pc2UnapprovedRecord::PC2_TABLES.each do |record|
      count = Pc2UnapprovedRecord.where("pc2_approvable_type =?",record).count 
      result << {:record_type => record, :record_count => count}
    end
    result
  end
end
