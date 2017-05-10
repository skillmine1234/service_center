class Ic001IncomingRecordSearcher
  attr_accessor :page, :anchor_account_id, :from_amount, :to_amount, :invoice_no, :status, :file_name, :overrided_flag
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
    reln = Ic001IncomingRecord.joins(:incoming_file_record).where("ic001_incoming_records.file_name=? and incoming_file_records.status=?",file_name,status).order("ic001_incoming_records.id desc")
    reln = reln.where("incoming_file_records.overrides is not null") if overrided_flag.present? and overrided_flag == "true"
    reln = reln.where("incoming_file_records.overrides is null") if overrided_flag.present? and overrided_flag == "false"
    reln = reln.where("ic001_incoming_records.anchor_account_id=?",anchor_account_id) if anchor_account_id.present?
    reln = reln.where("ic001_incoming_records.invoice_no=?",invoice_no) if invoice_no.present?
    reln = reln.where("ic001_incoming_records.invoice_amount>=? and ic001_incoming_records.invoice_amount<=?", from_amount.to_f,to_amount.to_f) if to_amount.present? and from_amount.present?
    reln
  end
end