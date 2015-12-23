class EcolCustomer < ActiveRecord::Base  
  include Approval
  include EcolApproval
  include EcolCustomerValidation
  include EcolCustomerOptions

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :code, :name, :is_enabled, :val_method, :token_1_type, :token_1_length, :val_token_1, :token_2_type,
  :token_2_length, :val_token_2, :token_3_type, :token_3_length, :val_token_3, :val_txn_date, :val_txn_amt, :val_ben_name, :val_rem_acct, 
  :return_if_val_reject, :nrtv_sufx_1, :nrtv_sufx_2, :nrtv_sufx_3, :rmtr_alert_on, :credit_acct_val_pass
  
  validates_uniqueness_of :code, :scope => :approval_status
  
  validates :token_1_length, :token_2_length, :token_3_length, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 29}
  
  validates_inclusion_of :val_method, :in => %w( N W D )
  validates_inclusion_of :token_1_type, :token_2_type, :token_3_type, :in => %w( N SC RC IN )
  validates_inclusion_of :file_upld_mthd, :in => %w( N F I ), :allow_blank => true
  validates_inclusion_of :nrtv_sufx_1, :nrtv_sufx_2, :nrtv_sufx_3, :in => %w( N SC RC IN RN ORN ORA TUN UDF1 UDF2 )
  validates_inclusion_of :rmtr_alert_on, :in => %w( N P R A )
  
  validates :code, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: {maximum: 15, minimum: 1}
  validates :name, format: {with: /\A[a-z|A-Z|0-9\s]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9\s]}' }, length: {maximum: 50, minimum: 5}
  validates :credit_acct_val_pass, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}' }, length: {maximum: 25, minimum: 10}
  validates :credit_acct_val_fail, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}' }, length: {maximum: 25, minimum: 10}, :allow_blank => true
  validates :rmtr_pass_txt, format: {with: /\A[a-z|A-Z|0-9|\.|\,\s]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\.|\,\s]}' }, length: {maximum: 500, minimum: 1}, :allow_blank => true
  validates :rmtr_return_txt, format: {with: /\A[a-z|A-Z|0-9|\.|\,\s]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\.|\,\s]}' }, length: {maximum: 500, minimum: 1}, :allow_blank => true
  validates :customer_id, presence: true, format: {with: /\A[1-9][0-9]+\z/, :message => 'should not start with a 0 and should contain only numbers'}, length: {maximum: 50}
  
  before_save :to_upcase

  def customer_code_format
    if !code.nil? && code.start_with?("9")
      unless code =~ /\A(9[0-9]{3})\Z/i
        errors.add(:code, "the code can be either a 4 digit number starting with 9, or a 6 character alpha-numeric code, that does not start with 9")
      end
    else
      unless code =~ /\A[0-9A-Za-z]{6}\Z/i
        errors.add(:code, "the code can be either a 4 digit number starting with 9, or a 6 character alpha-numeric code, that does not start with 9")
      end
    end
  end
  
  def account_token_types
    [self.token_1_type, self.token_2_type, self.token_3_type]
  end  
  
  def validate_account_token_length
    if ((self.token_1_type != 'N' && self.token_1_length == 0) || 
      (self.token_2_type != 'N' && self.token_2_length == 0) || 
      (self.token_3_type != 'N' && self.token_3_length == 0))
      errors[:base] << "If Account Token Type is not None then the corresponding Token Length should be greater than 0"
    end
  end
  
  def value_of_validation_fields
    if (self.val_token_1 == 'N' && self.val_token_2 == 'N' && self.val_token_3 == 'N' &&
       (self.val_txn_date != 'N' || self.val_txn_amt != 'N' || self.val_rem_acct != 'N'))
      errors[:base] << "Transaction Date, Transaction Amount and Remitter Account cannot be validated as no Token is validated"
    end
  end
  
  def to_upcase
    unless self.frozen? 
      self.code = self.code.upcase
      self.token_1_starts_with = self.token_1_starts_with.upcase unless self.token_1_starts_with.nil?
      self.token_1_contains = self.token_1_contains.upcase unless self.token_1_contains.nil?
      self.token_1_ends_with = self.token_1_ends_with.upcase unless self.token_1_ends_with.nil?
      self.token_2_starts_with = self.token_2_starts_with.upcase unless self.token_2_starts_with.nil?
      self.token_2_contains = self.token_2_contains.upcase unless self.token_2_contains.nil?
      self.token_2_ends_with = self.token_2_ends_with.upcase unless self.token_2_ends_with.nil?
      self.token_3_starts_with = self.token_3_starts_with.upcase unless self.token_3_starts_with.nil?
      self.token_3_contains = self.token_3_contains.upcase unless self.token_3_contains.nil?
      self.token_3_ends_with = self.token_3_ends_with.upcase unless self.token_3_ends_with.nil?
    end
  end
   
end
