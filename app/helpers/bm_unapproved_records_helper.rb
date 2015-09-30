module BmUnapprovedRecordsHelper
  
  def filter_records(records)
    result = []
    BmUnapprovedRecord::BM_TABLES.each do |record|
      count = BmUnapprovedRecord.where("bm_approvable_type =?",record).count 
      result << {:record_type => record, :record_count => count}
    end
    result
  end
end