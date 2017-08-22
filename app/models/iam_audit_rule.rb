class IamAuditRule < ActiveRecord::Base
  audited
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :org_uuid, :cert_dn, :source_ip, :interval_in_mins
  
  validates :interval_in_mins, numericality: {greater_than_or_equal_to: 1}
end
