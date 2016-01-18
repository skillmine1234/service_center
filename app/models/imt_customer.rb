class ImtCustomer < ActiveRecord::Base
  include Approval
  include ImtApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :customer_code, :customer_name, :contact_person, :email_id, :account_no, :mobile_no, :txn_mode
  
  validates :customer_code, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}'}, length: {maximum: 15}
  validates :account_no, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}' }, length: {maximum: 16}
  validates :mobile_no, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}'}, length: {maximum: 10, minimum: 10}
  validates :expiry_period, :numericality => { :greater_than => 0}
  
  def self.options_for_txn_mode
    [['File','F'],['Api','A']]
  end
end