class Pc2App < ActiveRecord::Base
  include Approval
  include Pc2Approval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates :customer_id, presence: true, :numericality => {:only_integer => true}, length: { maximum: 15 }
  validates_presence_of :app_id, :identity_user_id
  validates_uniqueness_of :customer_id, :scope => [:app_id, :approval_status]

  has_many :pc2_cust_accounts, :primary_key => 'customer_id', :foreign_key => 'customer_id', :class_name => 'Pc2CustAccount'
end
