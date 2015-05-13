class InwardRemittance < ActiveRecord::Base
  attr_accessible :attempt_no, :bank_ref, :bene_account_ifsc, :bene_account_no, :bene_address1, 
                  :bene_address2, :bene_address3, :bene_city, :bene_country, :bene_email_id, 
                  :bene_first_name, :bene_full_name, :bene_identity_count, :bene_last_name, 
                  :bene_mobile_no, :bene_postal_code, :bene_ref, :bene_state, :partner_code, 
                  :purpose_code, :rep_no, :rep_timestamp, :rep_version, :req_no, :req_timestamp, 
                  :req_version, :review_pending, :review_reqd, :rmtr_address1, :rmtr_address2, 
                  :rmtr_address3, :rmtr_city, :rmtr_country, :rmtr_email_id, :rmtr_first_name, 
                  :rmtr_full_name, :rmtr_identity_count, :rmtr_last_name, :rmtr_mobile_no, 
                  :rmtr_postal_code, :rmtr_state, :rmtr_to_bene_note, :status_code, 
                  :transfer_amount, :transfer_ccy, :transfer_type

  has_one :partner, :primary_key => 'partner_code', :foreign_key => 'code'
  has_one :purpose, :class_name => 'PurposeCode', :primary_key => 'purpose_code', :foreign_key => 'code'

  has_many :remitter_identities, :class_name => 'InwIdentity', :primary_key => 'req_no', :foreign_key => 'remittance_req_no', :conditions => {:id_req_type => 'Remitter'}
  has_many :beneficiary_identities, :class_name => 'InwIdentity', :primary_key => 'req_no', :foreign_key => 'remittance_req_no', :conditions => {:id_req_type => 'Beneficiary'}

  has_one :inw_audit_log

  validates_presence_of :req_no, :req_version, :req_timestamp, :partner_code, :rmtr_identity_count, 
                        :bene_identity_count, :attempt_no


  def remitter_address
    rmtr_address1.to_s + " " + rmtr_address2.to_s + " " + rmtr_address3.to_s
  end

  def beneficiary_address
    bene_address1.to_s + " " + bene_address2.to_s + " " + bene_address3.to_s
  end
end
