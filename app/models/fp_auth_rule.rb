class FpAuthRule < ActiveRecord::Base
  include Approval
  include FpApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :operation_name, :username
  validates_uniqueness_of :operation_name, :scope => [:username, :approval_status]
end