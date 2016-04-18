class FundsTransferCustomer < ActiveRecord::Base
  include Approval
  include FtApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :low_balance_alert_at, :identity_user_id, :name, :app_id
  validates :low_balance_alert_at, :numericality => { :greater_than => 0}
  validates_numericality_of :customer_id, :allow_blank => true
  validates :name, format: {with: /\A[a-z|A-Z|0-9\s]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9\s]}'}, length: {maximum: 20}
  validates_uniqueness_of :customer_id, :scope => :approval_status
  validates_uniqueness_of :app_id, :scope => :approval_status
  validate :validate_customer_id
  
  before_save :to_upcase

  def to_upcase
    unless self.frozen?
      self.name = self.name.upcase unless self.name.nil?
    end
  end

  def validate_customer_id
    errors.add(:customer_id,"is mandatory for Retail") if is_retail == 'N' and customer_id.to_s.empty?
  end
end