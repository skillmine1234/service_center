class EcolRemitter < ActiveRecord::Base
  include UdfValidation
  include EcolCustomersHelper
  
  audited
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  belongs_to :ecol_customer
  validates :ecol_customer, presence: true
  
  validates :customer_code, presence: true, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}'}, length: {maximum: 15, minimum: 1}
  validates :remitter_code, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: {maximum: 15, minimum: 1}, :allow_blank =>true
  validates :credit_acct_no, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: {maximum: 25, minimum: 1}, :allow_blank =>true
  validates :customer_subcode_email, format: {with: /\A[a-z|A-Z|0-9|\@|\.]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|@|.]}'}, length: {maximum: 100, minimum: 3}, :allow_blank =>true
  validates :customer_subcode_mobile, format: {with: /\A[0-9]{10}+\z/, :message => 'Invalid format, expected format is : {[0-9]{10}}' }, :allow_blank =>true 
  validates :remitter_name, presence: true, format: {with: /\A[a-z|A-Z|0-9|\:|\/|\-|\?|\+|\(|\)|\.|\,]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\:|\/|\-|\?|\+|\(|\)|\.|\,]}'}, length: {maximum: 100, minimum: 2}
  validates :remitter_address, format: {with: /\A[a-z|A-Z|0-9|\:|\/|\-|\?|\+|\(|\)|\.|\,]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\:|\/|\-|\?|\+|\(|\)|\.|\,]}'}, length: {maximum: 100, minimum: 2}, :allow_blank =>true
  validates :remitter_acct_no, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: {maximum: 25, minimum: 1}, :allow_blank =>true
  validates :remitter_email, format: {with: /\A[a-z|A-Z|0-9|@|.]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|@|.]}' }, length: {maximum: 100, minimum: 3}, :allow_blank =>true
  validates :remitter_mobile, format: {with: /\A[0-9]{10}+\z/, :message => 'Invalid format, expected format is : {[0-9]{10}}'}, :allow_blank =>true
  validates :invoice_no, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: {maximum: 15, minimum: 1}, :allow_blank =>true
  
  validates :invoice_amt, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e15'.to_f, :allow_nil => true }
  validates :invoice_amt_tol_pct, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100, :allow_nil => true }
  validates :min_credit_amt, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e15'.to_f, :allow_nil => true }
  validates :max_credit_amt, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e15'.to_f, :allow_nil => true }
  validates :due_date_tol_days, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 28, :allow_nil => true }
  
  validate :customer_subcode_details_should_be_nil_if_customer_subcode_is_nil, :customer_code_should_exist
  
  validate :value_types
  validate :mandatory_value
  validate :constraints
  
  def customer_subcode_details_should_be_nil_if_customer_subcode_is_nil
    if (self.customer_subcode == "" && (self.customer_subcode_email != "" || self.customer_subcode_mobile != "")) 
      errors[:base] << "Customer Sub Code Email and Mobile should be nil if Customer Sub Code is nil"
    end
  end 
  
  def udfs
    UdfAttribute.where("is_enabled=?",'Y').order("id asc")
  end
  
  def customer_code_should_exist
    ecol_customer = find_ecol_customers({:code => self.customer_code})
    if ecol_customer.blank? 
      errors.add(:customer_code, "Invalid Customer")
    end
  end
  
end
