class FundsTransferCustomer < ActiveRecord::Base
  include Approval
  include FtApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :account_no, :account_ifsc, :low_balance_alert_at, :identity_user_id, :customer_id
  validates :account_ifsc, format: {with: /\A[A-Z|a-z]{4}[0][0-9]{6}+\z/, message: "Invalid format - expected format is : {[A-Z|a-z]{4}[0][0-9]{6}}" }, length: {maximum: 11}
  validates :account_no, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: {maximum: 20}
  validates :mobile_no, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}'}, length: {maximum: 10, minimum: 10}
  validates :low_balance_alert_at, :numericality => { :greater_than => 0}
  validates :tech_email_id, :ops_email_id, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :message => 'Invalid Email ID, expected format is abc@def.com' }, :allow_blank => true
  validates_numericality_of :mmid, :allow_blank => true
  validates_numericality_of :customer_id
  
  before_save :to_upcase
  validate :validate_presence_of_mmid
  
  def country_name
    country = ISO3166::Country[self.country]
    country.translations[I18n.locale.to_s] || country.name rescue nil
  end
  
  def to_upcase
    unless self.frozen?
      self.name = self.name.upcase unless self.name.nil?
      self.account_no = self.account_no.upcase unless self.account_no.nil?
    end
  end
  
  def validate_presence_of_mmid
    errors.add(:mmid, "MMID is mandatory if IMPS is allowed") if self.allow_imps == 'Y' and self.mmid.blank?
  end
  
end
