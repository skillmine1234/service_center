class IcSupplier < ActiveRecord::Base
  include Approval
  include IcApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :supplier_code, :supplier_name, :customer_id, :od_account_no, :ca_account_no, :is_enabled
  validates :supplier_code, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }
  validates :supplier_name, format: {with: /\A[a-z|A-Z|0-9|\s|\.|\-]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\s|\.|\-]}'}
  validates_numericality_of :customer_id, :od_account_no, :ca_account_no, :message => 'Invalid format, expected format is : {[0-9]}'
  validates_uniqueness_of :supplier_code, :scope => [:customer_id, :approval_status]

  validates :customer_id, length: { minimum: 3, maximum: 15 }
  validates :supplier_code, length: { maximum: 15 }
  [:od_account_no, :ca_account_no].each do |column|
    validates column, length: { maximum: 20 }
  end
  validates :supplier_name, length: { maximum: 100 }
end
