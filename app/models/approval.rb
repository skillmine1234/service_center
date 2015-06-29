module Approval  
  extend ActiveSupport::Concern
  included do
    audited except: [:approval_status, :last_action]

    has_one :ecol_unapproved_record, :as => :ecol_approvable
    belongs_to :unapproved_record, :primary_key => 'approved_id', :foreign_key => 'id', :class_name => self.name, :unscoped => true
    belongs_to :approved_record, :foreign_key => 'approved_id', :primary_key => 'id', :class_name => self.name, :unscoped => true

    validates_uniqueness_of :approved_id, :allow_blank => true
    validate :validate_unapproved_record
    
    after_create :create_ecol_unapproved_records
    after_update :remove_ecol_unapproved_records

    def self.default_scope
      where approval_status: 'A'
    end
  end

  def create_ecol_unapproved_records
    if approval_status == 'U' and ecol_unapproved_record.nil?
      EcolUnapprovedRecord.create!(:ecol_approvable => self)
    end
  end

  def remove_ecol_unapproved_records
    if approval_status == 'A' and !ecol_unapproved_record.nil?
      ecol_unapproved_record.delete
    end
  end

  def validate_unapproved_record
    errors.add(:base,"Unapproved Record Already Exists for this record") if !unapproved_record.nil? and (approval_status == 'A' and approval_status_was == 'A')
  end

  def approve
    return "The record version is different from that of the approved version" if !self.approved_record.nil? and self.approved_version != self.approved_record.lock_version    
    self.approval_status = 'A'
    self.approved_record.delete unless self.approved_record.nil?
    return ""
  end

  def enable_approve_button?
    self.approval_status == 'U' ? true : false
  end
end