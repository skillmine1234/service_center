module EcolApproval  
  extend ActiveSupport::Concern
  included do
    has_one :ecol_unapproved_record, :as => :ecol_approvable

    after_create :create_ecol_unapproved_records
    after_update :remove_ecol_unapproved_records
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
end