class FpOperation < ActiveRecord::Base
  include Approval
  include FpApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :operation_name
  validates_uniqueness_of :operation_name, :scope => :approval_status
  
  validate :check_approval_status, :on => :create

  def check_approval_status
    if self.approval_status == 'U' and self.approved_record.present?
      errors[:base] << "You cannot edit this record as it is already approved!"
    end
  end
end