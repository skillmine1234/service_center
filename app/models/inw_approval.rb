module InwApproval  
  extend ActiveSupport::Concern
  included do
    has_one :inw_unapproved_record, :as => :inw_approvable

    after_create :create_inw_unapproved_records
    after_update :remove_inw_unapproved_records
  end

  def create_inw_unapproved_records
    if approval_status == 'U' and inw_unapproved_record.nil?
      InwUnapprovedRecord.create!(:inw_approvable => self)
    end
  end

  def remove_inw_unapproved_records
    if approval_status == 'A' and !inw_unapproved_record.nil?
      inw_unapproved_record.delete
    end
  end
end