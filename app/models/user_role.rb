class UserRole < ActiveRecord::Base
  include Approval
  include InwApproval
  
  belongs_to :user
  belongs_to :role
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'AdminUser'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'AdminUser'

  validates_uniqueness_of :user_id, :scope => :approval_status
  validates_presence_of :user_id,:role_id
end