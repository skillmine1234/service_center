class InwardRemittanceSearcher
  include ActiveModel::Validations
  attr_accessor :page, :status_code, :all_attempts, :req_no, :request_no, :partner_code, :bank_ref, :rmtr_full_name, :req_transfer_type, :transfer_type,
                :from_amount, :to_amount, :from_date, :to_date, :wl_id, :wl_id_for, :rmtr_code, :bene_account_no, :bene_account_ifsc
  PER_PAGE = 10
  
  validate :validate_search_criteria

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def paginate
    if valid? 
      find.paginate(per_page: PER_PAGE, page: page)
    else
      InwardRemittance.none.paginate(per_page: PER_PAGE, page: page)
    end
  end

  private
  def validate_search_criteria
    if partner_code.blank? && (all_attempts.present? || request_no.present? || status_code.present? || bank_ref.present? || rmtr_full_name.present? ||
      req_transfer_type.present? || transfer_type.present? || from_amount.present? || to_amount.present? || from_date.present? || to_date.present? ||
      wl_id.present? || rmtr_code.present? || bene_account_ifsc.present? || bene_account_no.present? )
      errors[:base] << "Partner code is mandatory" 
    end
  end
  
  def persisted?
    false
  end

  def find
    if all_attempts
      # show all attempts for the req_no
      reln = InwardRemittance.order("id desc").where("inward_remittances.req_no=?",req_no)
    else
      # show only one (latest) attempt per req_no
      maxQuery = InwardRemittance.select("max(attempt_no) as attempt_no,req_no").group(:req_no)
      reln = InwardRemittance.joins("inner join (#{maxQuery.to_sql}) a on a.req_no=inward_remittances.req_no and a.attempt_no=inward_remittances.attempt_no").order("inward_remittances.id DESC")      
    end

    reln = reln.where("inward_remittances.status_code=?", status_code) if status_code.present?
    reln = reln.where("inward_remittances.req_no LIKE ?", "#{request_no}%") if request_no.present?
    reln = reln.where("lower(inward_remittances.partner_code) LIKE ?", "#{partner_code.downcase}%") if partner_code.present?
    reln = reln.where("inward_remittances.bank_ref=?", bank_ref) if bank_ref.present?
    reln = reln.where("inward_remittances.rmtr_full_name=?", rmtr_full_name) if rmtr_full_name.present?
    reln = reln.where("inward_remittances.req_transfer_type=?", req_transfer_type) if req_transfer_type.present?
    reln = reln.where("inward_remittances.transfer_type=?", transfer_type) if transfer_type.present?
    reln = reln.where("inward_remittances.transfer_amount>=? and inward_remittances.transfer_amount <=?",from_amount.to_f, to_amount.to_f) if to_amount.present? && from_amount.present?
    reln = reln.where("inward_remittances.req_timestamp>=? and inward_remittances.req_timestamp<=?",Time.zone.parse(from_date).beginning_of_day,Time.zone.parse(to_date).end_of_day) if from_date.present? && to_date.present?
    reln = reln.where("inward_remittances.rmtr_wl_id=?", wl_id) if wl_id.present? && wl_id_for == 'R'
    reln = reln.where("inward_remittances.bene_wl_id=?", wl_id) if wl_id.present? && wl_id_for == 'B'
    reln = reln.where("inward_remittances.rmtr_code=?", rmtr_code) if rmtr_code.present?
    reln = reln.where("inward_remittances.bene_account_no=?", bene_account_no) if bene_account_no.present?
    reln = reln.where("inward_remittances.bene_account_ifsc=?", bene_account_ifsc) if bene_account_ifsc.present?

    reln
  end
end
