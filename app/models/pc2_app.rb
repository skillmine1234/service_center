class Pc2App < ActiveRecord::Base
  include Approval
  include Pc2Approval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :app_id, :identity_user_id, :customer_id
  validates_uniqueness_of :app_id, :scope => :approval_status
  
  validates_numericality_of :customer_id 
end
