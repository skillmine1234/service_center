class PcApp < ActiveRecord::Base
  include Approval
  include PcApproval

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  belongs_to :pc_program, :foreign_key => 'program_code', :primary_key => 'code',:class_name => 'PcProgram'
  
  validates_presence_of :app_id, :program_code, :identity_user_id
  validates_uniqueness_of :app_id, :scope => :approval_status
  validates :app_id, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => "Invalid format, expected format is : {[a-z|A-Z|0-9]}" }, length: { minimum: 5,  maximum: 20 }
  validates :identity_user_id, format: {with: /\A[0-9]+\z/, :message => "Invalid format, expected format is : {[0-9]}" }, length: { minimum: 1,  maximum: 20 }
end
