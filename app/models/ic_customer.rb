class IcCustomer < ActiveRecord::Base
  include Approval
  include IcApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :customer_id, :app_id, :repay_account_no, :is_enabled, :customer_name, :identity_user_id

  validates :identity_user_id, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}'}
  validates :app_id, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}'}
  validates :customer_name, format: {with: /\A[a-z|A-Z|0-9|\s|\.|\-]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\s|\.|\-]}'}
  validates :fee_pct, :max_overdue_pct, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }, allow_blank: true
  validates :customer_id, :repay_account_no, :numericality => {:only_integer => true, :message => 'Invalid format, expected format is : {[0-9]}'}
  validates :fee_income_gl, :numericality => {:only_integer => true, :message => 'Invalid format, expected format is : {[0-9]}'}, allow_blank: true

  validates_uniqueness_of :customer_id, :scope => :approval_status
  validates_uniqueness_of :app_id, :scope => :approval_status
  validates_uniqueness_of :identity_user_id, :scope => :approval_status
  validates_uniqueness_of :repay_account_no, :scope => :approval_status


  validates_inclusion_of :sc_backend_code, :in => %w( PURATECH ), :allow_blank => true

  validates :app_id, length: { minimum: 5, maximum: 20 }
  validates :customer_id, length: { minimum: 3, maximum: 15 }
  validates :repay_account_no, length: { minimum: 10, maximum: 20 }
  validates :fee_income_gl, length: { minimum: 3, maximum: 20 }, allow_blank: true
  validates :identity_user_id, length: { maximum: 20 }

  [:cust_contact_email, :ops_email, :rm_email, :customer_name].each do |column|
    validates column, length: { maximum: 100 }, :allow_blank =>true
  end
  validates :cust_contact_mobile, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}'}, length: {maximum: 10, minimum: 10}, :allow_blank =>true

  validate :check_email_addresses
  
  validate :fields_based_on_sc_backend_code

  def check_email_addresses
    ["cust_contact_email","ops_email","rm_email"].each do |email_id|
      invalid_ids = []
      value = self.send(email_id)
      unless value.nil?
        value.split(/;\s*/).each do |email| 
          unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
            invalid_ids << email
          end
        end
      end
      errors.add(email_id.to_sym, "is invalid, expected format is abc@def.com") unless invalid_ids.empty?
    end
  end

  def self.options_for_backend_code
    [['PuraTech','PURATECH']]
  end
  
  def fields_based_on_sc_backend_code
    if self.sc_backend_code.present? && (self.fee_pct.present? || self.fee_income_gl.present? || self.max_overdue_pct.present? || self.cust_contact_email.present? || 
      self.cust_contact_mobile.present? || self.ops_email.present? || self.rm_email.present?)
      errors[:base] << 'Fee Percentage, Fee Income Account No, Maximum Overdue Percentage, Customer Email, Customer Mobile No, Operations Email and Relationship Manager Email are not allowed when Backend System is PURATECH'
    elsif self.sc_backend_code.blank? && (self.fee_pct.nil? || self.fee_income_gl.nil? || self.max_overdue_pct.nil?)
      errors[:base] << 'Fee Percentage, Fee Income Account No and Maximum Overdue Percentage are mandatory when Backend System is null'
    end
  end
end
