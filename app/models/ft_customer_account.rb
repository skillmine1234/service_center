class FtCustomerAccount < ActiveRecord::Base
  include Approval
  include FtApproval

  self.table_name = "ft_cust_accounts"
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  belongs_to :funds_transfer_customer, :foreign_key => 'customer_id', :primary_key => 'customer_id'
  
  validates_presence_of :customer_id, :account_no, :is_enabled
  validates :customer_id, :account_no, :numericality => {:only_integer => true, :message => 'Invalid format, expected format is : {[0-9]}'}
  validates_uniqueness_of :customer_id, :scope => [:account_no,:approval_status]
  
  validates :customer_id, length: { minimum: 5, maximum: 10 }
  validates :account_no, length: { minimum: 5, maximum: 15 }

  validate :validate_customer_id

  def validate_customer_id
    customers = FundsTransferCustomer.where("customer_id =? and enabled =?", customer_id, 'Y')
    errors.add(:customer_id,"not valid") if customers.empty?
  end
end
