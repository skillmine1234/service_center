module Pc2Approval  
  extend ActiveSupport::Concern
  included do
    has_one :pc2_unapproved_record, :as => :pc2_approvable

    after_create :on_create_create_pc2_unapproved_record
    after_destroy :on_destory_remove_pc2_unapproved_records
    after_update :on_update_remove_pc2_unapproved_records
  end

  def on_create_create_pc2_unapproved_record
    if approval_status == 'U'
      Pc2UnapprovedRecord.create!(:pc2_approvable => self)
    end
  end

  def on_destory_remove_pc2_unapproved_records
    if approval_status == 'U'
      pc2_unapproved_record.delete
    end
  end
  
  def on_update_remove_pc2_unapproved_records
    if approval_status == 'A' and approval_status_was == 'U'
      pc2_unapproved_record.delete
    end
  end 
  
end