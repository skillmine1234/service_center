class RcTransferSearcher
  include ActiveModel::Validations
  attr_accessor :page, :rc_code, :bene_account_no, :debit_account_no, :from_amount, :to_amount, :status, :notify_status, :mobile_no, :pending_approval
  PER_PAGE = 10
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def paginate
    if valid? 
      find.paginate(per_page: PER_PAGE, page: page)
    else
      RcTransfer.none.paginate(per_page: PER_PAGE, page: page)
    end
  end

  private  
  def persisted?
    false
  end

  def find
    reln = RcTransfer.order("id desc")
    reln = reln.where("rc_transfer_code=?", rc_code) if rc_code.present?
    reln = reln.where("bene_account_no=?", bene_account_no) if bene_account_no.present?
    reln = reln.where("debit_account_no=?", debit_account_no) if debit_account_no.present?
    reln = reln.where("transfer_amount>=? and transfer_amount <=?",from_amount.to_f,to_amount.to_f) if to_amount.present? && from_amount.present?
    reln = reln.where("status_code=?",status) if status.present?
    reln = reln.where("notify_status=?",notify_status) if notify_status.present?
    reln = reln.where("mobile_no=?", mobile_no) if mobile_no.present?
    reln = reln.where("pending_approval=?", pending_approval) if pending_approval.present?
    reln
  end
end