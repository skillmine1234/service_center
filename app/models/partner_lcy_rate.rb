class PartnerLcyRate < ActiveRecord::Base
  include Approval
  include InwApproval

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  belongs_to :partner, :foreign_key =>'partner_code', :primary_key => 'code', :class_name => 'Partner'

  validates_presence_of :partner_code, :is_enabled, :rate
  validates_uniqueness_of :partner_code, :scope => :approval_status
  validates :partner_code, format: {with: /\A[A-Za-z0-9]+\z/, message: "invalid format - expected format is : {[A-Za-z0-9\s]}"}, length: {maximum: 10, minimum: 1}
  validates :rate, :numericality => { :greater_than_or_equal_to => 1 }
  validate :lcy_rate_is_valid_decimal_precision

  def lcy_rate_is_valid_decimal_precision
    errors.add(:rate, "is invalid, only two digits are allowed after decimal point") if rate.to_f != rate.to_f.round(2)
  end
end
