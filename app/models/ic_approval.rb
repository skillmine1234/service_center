module IcApproval  
  extend ActiveSupport::Concern
  included do
    has_one :ic_unapproved_record, :as => :ic_approvable

    after_create :on_create_create_ic_unapproved_record
    after_destroy :on_destory_remove_ic_unapproved_records
    after_update :on_update_remove_ic_unapproved_records
  end

  def on_create_create_ic_unapproved_record
    if approval_status == 'U'
      IcUnapprovedRecord.create!(:ic_approvable => self)
    end
  end

  def on_destory_remove_ic_unapproved_records
    if approval_status == 'U'
      ic_unapproved_record.delete
    end
  end
  
  def on_update_remove_ic_unapproved_records
    if approval_status == 'A' and approval_status_was == 'U'
      ic_unapproved_record.delete
    end
  end 
  
end