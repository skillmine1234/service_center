module BmApproval  
  extend ActiveSupport::Concern
  included do
    has_one :bm_unapproved_record, :as => :bm_approvable

    after_create :on_create_create_bm_unapproved_record
    after_destroy :on_destory_remove_bm_unapproved_records
    after_update :on_update_remove_bm_unapproved_records
  end

  def on_create_create_bm_unapproved_record
    if approval_status == 'U'
      BmUnapprovedRecord.create!(:bm_approvable => self)
    end
  end
  
  def on_destory_remove_bm_unapproved_records
    if approval_status == 'U'
      bm_unapproved_record.delete
    end
  end
  
  def on_update_remove_bm_unapproved_records
    if approval_status == 'A' and approval_status_was == 'U'
      bm_unapproved_record.delete
    end
  end 
end