class FundsTransferCustomer < ActiveRecord::Base
  include Approval
  include FtApproval

  self.table_name = "ft_customers"
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  has_many :ft_customer_accounts, :primary_key => 'customer_id', :foreign_key => 'customer_id', :class_name => 'FtCustomerAccount'
  
  validates_presence_of :low_balance_alert_at, :identity_user_id, :name, :app_id, :allow_all_accounts
  validates :low_balance_alert_at, :numericality => { :greater_than => 0}
  validates :identity_user_id, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}'}, :allow_blank => true
  validates :app_id, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}'}
  validates :name, format: {with: /\A[a-z|A-Z|0-9|\s|\.|\-]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\s|\.|\-]}'}
  validates :customer_id, :numericality => {:only_integer => true, :message => 'Invalid format, expected format is : {[0-9]}', :allow_blank => true}
  validates_uniqueness_of :app_id, :scope => [:customer_id,:approval_status]
  validate :validate_customer_id
  
  validates :app_id, length: { minimum: 5, maximum: 20 }
  validates :customer_id, length: { minimum: 5, maximum: 10 }, :allow_blank =>true
  validates :name, length: {maximum: 100 }
  validates :identity_user_id, length: { maximum: 20 }

  before_save :to_upcase

  def to_upcase
    unless self.frozen?
      self.name = self.name.upcase unless self.name.nil?
    end
  end

  def validate_customer_id
    errors.add(:customer_id,"is mandatory for corporate") if is_retail == 'N' and customer_id.to_s.empty?
  end
end