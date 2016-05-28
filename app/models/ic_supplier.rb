class IcSupplier < ActiveRecord::Base
  include Approval
  include IcApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :corp_customer_id, :supplier_code, :supplier_name, :customer_id, :od_account_no, :ca_account_no, :is_enabled
  validates :supplier_code, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }
  validates :supplier_name, format: {with: /\A[a-z|A-Z|0-9|\s|\.|\-]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\s|\.|\-]}'}
  validates_numericality_of :corp_customer_id, :customer_id, :od_account_no, :ca_account_no, :message => 'Invalid format, expected format is : {[0-9]}'
  validates_uniqueness_of :supplier_code, :scope => [:customer_id, :approval_status]

  validates :corp_customer_id, :customer_id, :supplier_code, length: { minimum: 3, maximum: 10 }
  validates :od_account_no, :ca_account_no, length: { minimum: 10, maximum: 20 }
  validates :supplier_name, length: { maximum: 100 }
  validate :validate_corp_customer_id

  def validate_corp_customer_id
    customer = IcCustomer.where("customer_id=?",corp_customer_id)
    errors.add(:corp_customer_id, "is not present in customers") if customer.empty?
  end
end
