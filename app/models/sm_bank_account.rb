class SmBankAccount < ActiveRecord::Base
  include Approval
  include SmApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :sm_code, :customer_id, :account_no, :mmid, :mobile_no

  validates :sm_code, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: { maximum: 20 }
  validates :customer_id, numericality: { only_integer: true }, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}'},length: { minimum: 3, maximum: 15 }
  validates :account_no, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: { minimum: 1, maximum: 15 }
  validates :mmid, numericality: { only_integer: true }, length: { minimum: 7, maximum: 7 }
  validates :mobile_no, numericality: { only_integer: true }, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}'}, length: {maximum: 10, minimum: 10}
  
  validates_uniqueness_of :sm_code, :scope => [:customer_id, :account_no, :approval_status]

  before_save :to_downcase

  def to_downcase
    unless self.frozen?
      self.sm_code = self.sm_code.downcase unless self.sm_code.nil?
      self.account_no = self.account_no.downcase unless self.account_no.nil?
    end
  end
end