module InwApproval  
  extend ActiveSupport::Concern
  included do
    has_one :inw_unapproved_record, :as => :inw_approvable

    after_create :on_create_create_inw_unapproved_record
    after_destroy :on_destory_remove_inw_unapproved_records
    after_update :on_update_remove_inw_unapproved_records
  end

  def on_create_create_inw_unapproved_record
    if approval_status == 'U'
      InwUnapprovedRecord.create!(:inw_approvable => self)
    end
  end
  
  def on_destory_remove_inw_unapproved_records
    if approval_status == 'U'
      inw_unapproved_record.delete
    end
  end
  
  def on_update_remove_inw_unapproved_records
    if approval_status == 'A' and approval_status_was == 'U'
      inw_unapproved_record.delete
    end
  end 
end