class SmBank < ActiveRecord::Base
  include Approval
  include SmApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :code, :name, :bank_code, :identity_user_id, :neft_allowed, :imps_allowed, :is_enabled

  validates :code, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: {maximum: 20}
  validates :name, format: {with: /\A[a-z|A-Z|0-9|\s|\.|\-]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\s|\.|\-]}' }, length: {maximum: 100}
  validates :bank_code, format: {with: /\A[A-Z|a-z]{4}[0][A-Za-z0-9]{6}+\z/, message: "invalid format - expected format is : {[A-Z|a-z]{4}[0][A-Za-z0-9]{6}}" }
  validates :low_balance_alert_at, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e20'.to_f }
  validates :identity_user_id, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}'}, length: {maximum: 20}

  validates_uniqueness_of :code, :scope => :approval_status

  before_save :to_downcase, :set_low_balance_alert_at_if_nil

  def to_downcase
    unless self.frozen?
      self.code = self.code.downcase unless self.code.nil?
      self.name = self.name.downcase unless self.name.nil?
      self.bank_code = self.bank_code.downcase unless self.bank_code.nil?
    end
  end

  def set_low_balance_alert_at_if_nil
    unless self.frozen?
      self.low_balance_alert_at = 0 if self.low_balance_alert_at.nil?
    end
  end
end