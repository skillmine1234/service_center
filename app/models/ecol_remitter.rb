class EcolRemitter < ActiveRecord::Base
  include UdfValidation
  include EcolCustomersHelper
  
  audited
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  belongs_to :ecol_customer
  
  validates :customer_code, presence: true, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}'}, length: {maximum: 15, minimum: 1}
  validates :customer_subcode, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}'}, length: {maximum: 15, minimum: 1}, :allow_blank =>true
  validates :remitter_code, presence: true, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: {maximum: 28, minimum: 1}
  validates :credit_acct_no, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}' }, length: {maximum: 25, minimum: 10}, :allow_blank =>true
  validates :customer_subcode_mobile, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}' }, length: {maximum: 10, minimum: 10}, :allow_blank =>true 
  validates :rmtr_name, presence: true, format: {with: /\A[a-z|A-Z|0-9|\:|\/|\-|\?|\+|\(|\)|\.|\,\s]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\:|\/|\-|\?|\+|\(|\)|\.|\,\s]}'}, length: {maximum: 100, minimum: 2}
  validates :rmtr_address, format: {with: /\A[a-z|A-Z|0-9|\:|\/|\-|\?|\+|\(|\)|\.|\,\s]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\:|\/|\-|\?|\+|\(|\)|\.|\,\s]}'}, length: {maximum: 100, minimum: 2}, :allow_blank =>true
  validates :rmtr_acct_no, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: {maximum: 25, minimum: 1}, :allow_blank =>true
  validates :rmtr_mobile, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}'}, length: {maximum: 10, minimum: 10}, :allow_blank =>true
  validates :invoice_no, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: {maximum: 28, minimum: 1}, :allow_blank =>true
  
  validates :invoice_amt, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e15'.to_f, :allow_nil => true }
  validates :invoice_amt_tol_pct, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100, :allow_nil => true }
  validates :min_credit_amt, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e15'.to_f, :allow_nil => true }
  validates :max_credit_amt, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e15'.to_f, :allow_nil => true }
  validates :due_date_tol_days, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 28, :allow_nil => true }
  
  validates_uniqueness_of :customer_code, :scope => [:remitter_code, :customer_subcode, :invoice_no]
  
  validate :validate_customer_subcode_details, :customer_code_should_exist, :check_email_address
  
  validate :value_types
  validate :mandatory_value
  validate :constraints
  
  def validate_customer_subcode_details
    if self.customer_subcode.blank? 
      errors.add(:customer_subcode_email,"should be empty when customer_subcode is empty") if !self.customer_subcode_email.blank?
      errors.add(:customer_subcode_mobile,"should be empty when customer_subcode is empty") if !self.customer_subcode_mobile.blank?
    end
  end 
  
  def udfs
    UdfAttribute.where("is_enabled=?",'Y').order("id asc")
  end
  
  def customer_code_should_exist
    ecol_customer = EcolCustomer.where(:code => self.customer_code)
    if ecol_customer.nil? 
      errors.add(:customer_code, "Invalid Customer")
    end
  end
  
  def check_email_address
    ["customer_subcode_email","rmtr_email"].each do |email_id|
      invalid_ids = []
      value = self.send(email_id)
      unless value.nil?
        value.split(/;\s*/).each do |email| 
          unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
            invalid_ids << email
          end
        end
      end
      errors.add(email_id.to_sym, "invalid email #{invalid_ids.join(',')}") unless invalid_ids.empty?
    end
  end
  
end
