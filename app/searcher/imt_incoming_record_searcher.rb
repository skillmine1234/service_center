class ImtIncomingRecordSearcher
  attr_accessor :page, :imt_ref_no, 
                :from_issue_date, :to_issue_date, :from_acquire_date, :to_acquire_date, 
                :from_amount, :to_amount, 
                :file_name, :status, :overrided_flag

  PER_PAGE = 10

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def paginate
    find.paginate(per_page: PER_PAGE, page: page)
  end

  private
  def persisted?
    false
  end

  def find
    reln = ImtIncomingRecord.joins(:incoming_file_record).where("imt_incoming_records.file_name=? and status=?",file_name,status).order("imt_incoming_records.id desc")
    reln = reln.where("incoming_file_records.overrides is not null") if overrided_flag.present? and overrided_flag == "true"
    reln = reln.where("incoming_file_records.overrides is null") if overrided_flag.present? and overrided_flag == "false"
    reln = reln.where("imt_incoming_records.imt_ref_no=?",imt_ref_no) if imt_ref_no.present?
    reln = reln.where("imt_incoming_records.txn_issue_date>=? and imt_incoming_records.txn_issue_date<=?",Time.zone.parse(from_issue_date).beginning_of_day,Time.zone.parse(to_issue_date).end_of_day) if from_issue_date.present? && to_issue_date.present?
    reln = reln.where("imt_incoming_records.txn_acquire_date>=? and imt_incoming_records.txn_acquire_date<=?",Time.zone.parse(from_acquire_date).beginning_of_day,Time.zone.parse(to_acquire_date).end_of_day) if from_acquire_date.present? && to_acquire_date.present?
    reln = reln.where("imt_incoming_records.amount>=? and imt_incoming_records.amount<=?", from_amount.to_f,to_amount.to_f) if from_amount.present? and to_amount.present?
    reln
  end
end