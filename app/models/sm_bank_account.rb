class SmBankAccount < ActiveRecord::Base
  include Approval
  include SmApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  belongs_to :sm_bank, :foreign_key => 'sm_code', :primary_key => 'bank_code'

  validates_presence_of :sm_code, :customer_id, :account_no, :is_enabled

  validates :sm_code, format: {with: /\A[A-Z]{4}[0][A-Z]{3}[0-9]{3}+\z/, message: "invalid format - expected format is : {[A-Z]{4}[0][A-Z]{3}[0-9]{3}}" }, length: {maximum: 20}
  validates :customer_id, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}'}, length: { minimum: 3, maximum: 15 }
  validates :account_no, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}' }, length: { minimum: 1, maximum: 15 }

  validates :mmid, format: {with: /\A[0-9]{7}+\z/, :message => 'Invalid format, expected format is : {[0-9]{7}}'}, length: { minimum: 7, maximum: 7 }, :allow_blank => true
  validates :mobile_no, format: {with: /\A[0-9]{10}+\z/, :message => 'Invalid format, expected format is : {[0-9]{10}}'}, length: {maximum: 10, minimum: 10}, :allow_blank => true
  
  validates_uniqueness_of :sm_code, :scope => [:customer_id, :account_no, :approval_status]
end