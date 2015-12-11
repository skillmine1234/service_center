module FpUnapprovedRecordsHelper
  def filter_records(records)
    result = []
    FpUnapprovedRecord::FP_TABLES.each do |record|
      count = FpUnapprovedRecord.where("fp_approvable_type =?",record).count 
      result << {:record_type => record, :record_count => count}
    end
    result
  end
end
