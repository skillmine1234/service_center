module BmApproval  
  extend ActiveSupport::Concern
  included do
    has_one :bm_unapproved_record, :as => :bm_approvable

    after_create :create_bm_unapproved_records
    after_update :remove_bm_unapproved_records
  end

  def create_bm_unapproved_records
    if approval_status == 'U' and bm_unapproved_record.nil?
      BmUnapprovedRecord.create!(:bm_approvable => self)
    end
  end

  def remove_bm_unapproved_records
    if approval_status == 'A' and !bm_unapproved_record.nil?
      bm_unapproved_record.delete
    end
  end
end