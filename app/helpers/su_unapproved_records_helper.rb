module SuUnapprovedRecordsHelper
  def filter_records(records)
    result = []
    SuUnapprovedRecord::SU_TABLES.each do |record|
      count = SuUnapprovedRecord.where("su_approvable_type =?",record).count 
      result << {:record_type => record, :record_count => count}
    end
    result
  end
end
