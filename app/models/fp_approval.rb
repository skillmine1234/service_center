module FpApproval  
  extend ActiveSupport::Concern
  included do
    has_one :fp_unapproved_record, :as => :fp_approvable

    after_create :on_create_create_fp_unapproved_record
    after_destroy :on_destory_remove_fp_unapproved_records
    after_update :on_update_remove_fp_unapproved_records
  end

  def on_create_create_fp_unapproved_record
    if approval_status == 'U'
      FpUnapprovedRecord.create!(:fp_approvable => self)
    end
  end

  def on_destory_remove_fp_unapproved_records
    if approval_status == 'U'
      fp_unapproved_record.delete
    end
  end
  
  def on_update_remove_fp_unapproved_records
    if approval_status == 'A' and approval_status_was == 'U'
      fp_unapproved_record.delete
    end
  end 
  
end