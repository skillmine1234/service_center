module EcolUnapprovedRecordsHelper
  
  def filter_records(records)
    result = []
    EcolUnapprovedRecord::ECOL_TABLES.each do |record|
      count = EcolUnapprovedRecord.where("ecol_approvable_type =?",record).count 
      result << {:record_type => record, :record_count => count}
    end
    result
  end
end