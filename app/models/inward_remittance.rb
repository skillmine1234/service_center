class InwardRemittance < ActiveRecord::Base
  has_one :partner, :primary_key => 'partner_code', :foreign_key => 'code'
  has_one :purpose, :class_name => 'PurposeCode', :primary_key => 'purpose_code', :foreign_key => 'code'

  has_many :remitter_identities, -> { where id_for: 'R'}, :class_name => 'InwIdentity', :foreign_key => 'inw_remittance_id'
  has_many :beneficiary_identities, -> { where id_for: 'B'}, :class_name => 'InwIdentity', :foreign_key => 'inw_remittance_id'
  has_many :identities, :class_name => 'InwIdentity', :foreign_key => 'inw_remittance_id'

  has_one :inw_audit_log
  has_one :inward_remittances_lock
  has_many :audit_steps, :class_name => 'InwAuditStep', :as => :inw_auditable

  validates_presence_of :req_no, :req_version, :req_timestamp, :partner_code, :rmtr_identity_count, 
                        :bene_identity_count, :attempt_no

  florrick do
    string :req_no
  end

  def remitter_address
    rmtr_address1.to_s + " " + rmtr_address2.to_s + " " + rmtr_address3.to_s
  end

  def beneficiary_address
    bene_address1.to_s + " " + bene_address2.to_s + " " + bene_address3.to_s
  end

  def reply_time
    ((rep_timestamp - req_timestamp)/1.minute).round rescue '0'
  end

  def self_transfer?
    is_self_transfer=='Y' ? true : false
  end

  def partner_name
    partner.try(:name) rescue nil
  end

  def same_party_transfer?
    is_same_party_transfer=='Y' ? true : false
  end
end
