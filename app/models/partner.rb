class Partner < ActiveRecord::Base
  audited
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :code, :name, :account_no, :txn_hold_period_days
  validates_uniqueness_of :code
  validates :low_balance_alert_at, :numericality => { :greater_than_or_equal_to => 0, :allow_nil => true }
  validates :account_no, :numericality => {:only_integer => true}, length: {in: 10..16}
  validates :account_ifsc, format: {with: /[A-Z|a-z]{4}[0][A-Za-z0-9]{6}$/ }
end
