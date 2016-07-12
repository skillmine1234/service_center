class SmBankAccount < ActiveRecord::Base
  include Approval
  include SmApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  belongs_to :sm_bank, :foreign_key => 'sm_code', :primary_key => 'code'

  validates_presence_of :sm_code, :customer_id, :account_no, :is_enabled

  validates :sm_code, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: { maximum: 20 }
  validates :customer_id, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}'}, length: { minimum: 3, maximum: 15 }
  validates :account_no, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}' }, length: { minimum: 1, maximum: 15 }

  validates :mmid, presence: true, format: {with: /\A[0-9]{7}+\z/, :message => 'Invalid format, expected format is : {[0-9]{7}}'}, length: { minimum: 7, maximum: 7 }, if: :is_mmid_and_mobile_no_mandatory?
  validates :mobile_no, presence: true, format: {with: /\A[0-9]{10}+\z/, :message => 'Invalid format, expected format is : {[0-9]{10}}'}, length: {maximum: 10, minimum: 10}, if: :is_mmid_and_mobile_no_mandatory?
  
  validates_uniqueness_of :sm_code, :scope => [:customer_id, :account_no, :approval_status]

  validate :validate_sm_code
  validate :is_mmid_and_mobile_no_mandatory?

  def validate_sm_code
    errors.add(:sm_code, "is not present in bank") if self.sm_bank.nil?
  end

  def is_mmid_and_mobile_no_mandatory?
    (sm_bank.imps_allowed? ? true : false) if !sm_bank.nil?
  end
end