class IcCustomer < ActiveRecord::Base
  include Approval
  include IcApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :customer_id, :app_id, :repay_account_no, :fee_pct, 
                        :fee_income_gl, :max_overdue_pct, :cust_contact_email, :cust_contact_mobile, 
                        :ops_email, :rm_email, :is_enabled, :customer_name

  validates :identity_user_id, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}'}, :allow_blank => true
  validates :app_id, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}'}
  validates :customer_name, format: {with: /\A[a-z|A-Z|0-9|\s|\.|\-]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\s|\.|\-]}'}
  validates :cust_contact_email, :ops_email, :rm_email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :message => 'Invalid Email ID, expected format is abc@def.com' }
  validates :fee_pct, :max_overdue_pct, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
  validates :customer_id, :repay_account_no, :fee_income_gl, :cust_contact_mobile, :numericality => {:only_integer => true, :message => 'Invalid format, expected format is : {[0-9]}'}

  validates_uniqueness_of :customer_id, :scope => :approval_status
  validates_uniqueness_of :app_id, :scope => :approval_status
  validates_uniqueness_of :identity_user_id, :scope => :approval_status
  validates_uniqueness_of :repay_account_no, :scope => :approval_status

  validates :app_id, length: { minimum: 5, maximum: 20 }
  validates :customer_id, length: { minimum: 3, maximum: 15 }

  [:identity_user_id, :repay_account_no, :fee_income_gl].each do |column|
    validates column, length: { maximum: 20 }
  end
  [:cust_contact_email, :ops_email, :rm_email, :customer_name].each do |column|
    validates column, length: { maximum: 100 }
  end
  validates :cust_contact_mobile, length: {maximum: 10, minimum: 10}
end
