module EcolApproval  
  extend ActiveSupport::Concern
  included do
    has_one :ecol_unapproved_record, :as => :ecol_approvable

    after_create :on_create_create_ecol_unapproved_record
    after_destroy :on_destory_remove_ecol_unapproved_records
    after_update :on_update_remove_ecol_unapproved_records
  end

  def on_create_create_ecol_unapproved_record
    if approval_status == 'U'
      EcolUnapprovedRecord.create!(:ecol_approvable => self)
    end
  end

  def on_destory_remove_ecol_unapproved_records
    if approval_status == 'U'
      ecol_unapproved_record.delete
    end
  end
  
  def on_update_remove_ecol_unapproved_records
    if approval_status == 'A' and approval_status_was == 'U'
      ecol_unapproved_record.delete
    end
  end 
  
end