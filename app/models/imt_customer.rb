class ImtCustomer < ActiveRecord::Base
  include Approval
  include ImtApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :customer_code, :customer_name, :contact_person, :email_id, :account_no, :mobile_no, :txn_mode, :expiry_period, :app_id, :identity_user_id
  validates_uniqueness_of :app_id, :scope => :approval_status
  
  validates :customer_code, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}'}, length: {maximum: 15}
  validates :customer_name, format: {with: /\A[a-z|A-Z|0-9|\s|\.]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\s|\.]}'}
  validates :contact_person, format: {with: /\A[a-z|A-Z|0-9|\s]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\s]}'}
  validates :account_no, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}' }, length: {maximum: 16}
  validates :mobile_no, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}'}, length: {maximum: 10, minimum: 10}
  validates :expiry_period, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 999, :only_integer => true}
  validates :email_id, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :message => 'Invalid Email ID, expected format is abc@def.com' }
  validates :address_line1, :address_line2, :address_line3, format: {with: /\A[a-z|A-Z|0-9|\s|\.|\,|\-]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\s|\.|\,|\-]}'}, :allow_blank => true

  validate :presence_of_iam_cust_user

  before_save :convert_customer_name_to_upcase
  
  def self.options_for_txn_mode
    [['File','F'],['Api','A']]
  end
  
  def country_name
    country = ISO3166::Country[self.country]
    country.translations[I18n.locale.to_s] || country.name rescue nil
  end
  
  def convert_customer_name_to_upcase
    self.customer_name = self.customer_name.upcase unless self.frozen?
  end

  def presence_of_iam_cust_user
    errors.add(:identity_user_id, 'IAM Customer User does not exist for this username') if IamCustUser.find_by(username: identity_user_id).nil?
  end
end