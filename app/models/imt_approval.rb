module ImtApproval  
  extend ActiveSupport::Concern
  included do
    has_one :imt_unapproved_record, :as => :imt_approvable

    after_create :on_create_create_imt_unapproved_record
    after_destroy :on_destory_remove_imt_unapproved_records
    after_update :on_update_remove_imt_unapproved_records
  end

  def on_create_create_imt_unapproved_record
    if approval_status == 'U'
      ImtUnapprovedRecord.create!(:imt_approvable => self)
    end
  end

  def on_destory_remove_imt_unapproved_records
    if approval_status == 'U'
      imt_unapproved_record.delete
    end
  end
  
  def on_update_remove_imt_unapproved_records
    if approval_status == 'A' and approval_status_was == 'U'
      imt_unapproved_record.delete
    end
  end 
  
end