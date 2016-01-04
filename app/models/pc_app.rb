class PcApp < ActiveRecord::Base
  include Approval
  include PcApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :app_id, :card_acct, :sc_gl_income, :card_cust_id
  validates_uniqueness_of :app_id, :scope => :approval_status
  
  validates :card_acct, :sc_gl_income, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => "Invalid format, expected format is : {[a-z|A-Z|0-9]}" }, length: {maximum: 15, minimum: 1}
end
