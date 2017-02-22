class WhitelistedIdentity < ActiveRecord::Base
  include Approval
  include InwApproval
  
  attr_accessor :txn_identity_no
  has_many :attachments, :as => :attachable
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  belongs_to :inward_remittance, :foreign_key => 'first_used_with_txn_id', :class_name => 'InwardRemittance'
  belongs_to :partner

  accepts_nested_attributes_for :attachments

  validates_presence_of :partner, :id_for, :created_for_req_no, :created_by, :id_type, :id_number, :id_expiry_date
  validates :txn_identity_no, numericality: { only_integer: true, allow_blank: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 3 }
  
  validate :validate_whitelisted_identity, :on => :create
  
  before_create :set_defaults_for_create
  
  # the after_save callbacks call database packages which arent avialable in the test environment
  after_save :release unless Rails.env.test? 

  private   
  def set_defaults_for_create
    partner = Partner.find_by_id(self.partner_id)
    inw_txn = InwardRemittance.find_last_attempt_for_req_no(partner.code, self.created_for_req_no)
    self.created_for_txn_id = inw_txn.id
    self.first_used_with_txn_id = inw_txn.id
    
    if partner.will_send_id == 'N'
      if id_for == 'B'
        self.bene_account_no = inw_txn.bene_account_no
        self.bene_account_ifsc = inw_txn.bene_account_ifsc
      else
        self.rmtr_code = inw_txn.rmtr_code
      end
    else
      inw_identity = inw_txn.identities[self.txn_identity_no.to_i]
      self.created_for_identity_id = inw_identity.id
    end
    
    self.is_revoked = 'N'
    self.is_verified = 'Y'
    self.verified_at = self.created_at
    self.verified_by = self.created_by
    self.times_used = 0
  end  
  
  # on the approval of the creation of the whitelisted identity a the association is done and a release is attempted
  def release
    if self.approval_status == 'A' && self.last_action = 'C'
      associate_and_try_release
      if self.partner.auto_match_rule == 'A'
        auto_match_and_release
      end
    end
  end
  
  def auto_match_and_release
    result = plsql.pk_qg_inw_wl_service.auto_match_and_release(pi_wl_id: self.id, po_fault_code: nil, po_fault_subcode: nil, po_fault_reason: nil)
    raise ::Fault::ProcedureFault.new(OpenStruct.new(code: result[:po_fault_code], subCode: result[:po_fault_subcode], reasonText: "#{result[:po_fault_reason]}")) if result[:po_fault_code].present?
  end

  def associate_and_try_release
    result = plsql.pk_qg_inw_wl_service.associate_and_try_release(pi_wl_id: self.id, po_fault_code: nil, po_fault_subcode: nil, po_fault_reason: nil)
    raise ::Fault::ProcedureFault.new(OpenStruct.new(code: result[:po_fault_code], subCode: result[:po_fault_subcode], reasonText: "#{result[:po_fault_reason]}")) if result[:po_fault_code].present?
  end

  def validate_whitelisted_identity_on_create
    validate_whitelisted_identity
  end
  
  def validate_whitelisted_identity
    inw_txn = InwardRemittance.find_last_attempt_for_req_no(partner.code, self.created_for_req_no)
    
    errors.add(:id_for, "should be either R or B") unless ['R','B'].include?(id_for)
    errors.add(:created_for_req_no, "no transaction found for req_no") if inw_txn.nil?
    errors.add(:id_expiry_date,"should not be less than today's date") if !id_expiry_date.nil? and id_expiry_date < Time.zone.today
    errors.add(:id_expiry_date,"should not be greater than issue date") if !id_expiry_date.nil? and !id_issue_date.nil? and id_expiry_date > id_issue_date
    errors.add(:id_type,"should not be the reserved word partnerProvidedID") if id_type == 'partnerProvidedID'

    unless inw_txn.nil?
      if id_for == 'B'
        errors.add(:full_name, "the name entered does not match the beneficiary name #{inw_txn.bene_full_name}") if inw_txn.bene_full_name != full_name
      else
        errors.add(:full_name, "the name entered does not match the remitter name #{inw_txn.rmtr_full_name}") if inw_txn.rmtr_full_name != full_name
      end
      
      errors.add(:full_name, "the transaction does not have any remitter code, choose a different transaction to whitelist this remitter ") if partner.will_send_id == 'N' and self.rmtr_code.nil? and self.id_for == 'R'
    end
   
    if partner.will_send_id == 'Y' 
      if self.txn_identity_no.blank?
        errors.add(:txn_identity_no,"the partner sends ID information in the request, choose a identity position ") 
      else
        inw_identity = inw_txn.identities[self.txn_identity_no.to_i]
        if inw_identity.nil?
          errors.add(:txn_identity_no,"the transaction has only #{inw_txn.identities.count} identities") 
        else
          errors.add(:id_expiry_date,"the expiry date provided does not match what came in the request : #{inw_identity.id_expiry_date}") if id_expiry_date != inw_identity.id_expiry_date
          errors.add(:id_issue_date,"the issue date provided does not match what came in the request : #{inw_identity.id_issue_date}") if id_issue_date != inw_identity.id_issue_date
          errors.add(:id_type,"the id type provided does not match what came in the request : #{inw_identity.id_type}") if id_type != inw_identity.id_type
          errors.add(:id_number,"the id number provided does not match what came in the request : #{inw_identity.id_number}") if id_number != inw_identity.id_number
          errors.add(:id_country,"the id country provided does not match what came in the request : #{inw_identity.id_country}") if id_country != inw_identity.id_country        
        end      
      end
    else
      errors.add(:txn_identity_no,"the partner does not ID information in the request, do not send any identity position") if txn_identity_no.present?
    end
    
  end
end