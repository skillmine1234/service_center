class PcApp < ActiveRecord::Base
  include Approval
  include PcApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :app_id, :card_acct, :sc_gl_income, :card_cust_id, :traceid_prefix, :source_id, :channel_id, :mm_host, :mm_consumer_key, :mm_consumer_secret, :mm_card_type, :mm_email_domain, :mm_admin_host, :mm_admin_user, :mm_admin_password
  validates_uniqueness_of :app_id, :scope => :approval_status
  
  validates :mm_host, format: { with: URI.regexp }
  validates :card_acct, :sc_gl_income, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => "Invalid format, expected format is : {[a-z|A-Z|0-9]}" }, length: {maximum: 15, minimum: 1}
  validates :card_cust_id, :mm_consumer_key, :mm_consumer_secret, :mm_card_type, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => "Invalid format, expected format is : {[a-z|A-Z|0-9]}" }
  validates :mm_email_domain, format: {with: /\A[a-z|A-Z|\.]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|\.]}' }
end
