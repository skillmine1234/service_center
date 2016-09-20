class PcFeeRule < ActiveRecord::Base
  include Approval
  include PcApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  belongs_to :pc_product, :foreign_key => 'product_code', :primary_key => 'code',:class_name => 'PcProduct'
  
  validates_presence_of :product_code, :txn_kind, :no_of_tiers, :tier1_to_amt, :tier1_max_sc_amt
  validates_uniqueness_of :product_code, :scope => [:txn_kind, :approval_status]
  validates :tier1_to_amt, :tier1_fixed_amt, :tier1_min_sc_amt, :tier2_to_amt, :tier2_fixed_amt, :tier2_min_sc_amt, :tier2_max_sc_amt, :tier3_fixed_amt, :tier3_min_sc_amt, :tier3_max_sc_amt, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 9999999999}, :allow_nil => true
  validates :tier1_max_sc_amt, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 9999999999}
  validates :tier1_pct_value, :tier2_pct_value, :tier3_pct_value, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}, :allow_blank => true
  validates :no_of_tiers, :numericality => {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 3 }
  validate :min_and_max_sc_amt
  validate :validate_to_amount

  def self.options_for_txn_kind
    [['loadCard','PcLoadCard'],['payToAccount','PcsPayToAccount'],['payToContact','PcsPayToContact'],['topUp','PcsTopUp']]
  end
  
  def self.options_for_tier_method
    [['Fixed','F'],['Percentage','P']]
  end
  
  def min_and_max_sc_amt
    unless (self.tier1_min_sc_amt.nil? and self.tier1_max_sc_amt.nil?)
      errors[:base] << "Tier 1 Minimum SC Amount should be less than Maximum SC Amount" if (self.tier1_min_sc_amt.to_f > self.tier1_max_sc_amt.to_f)
    end
    unless (self.tier2_min_sc_amt.nil? and self.tier2_max_sc_amt.nil?)
      errors[:base] << "Tier 2 Minimum SC Amount should be less than Maximum SC Amount" if (self.tier2_min_sc_amt.to_f > self.tier2_max_sc_amt.to_f)
    end
    unless (self.tier3_min_sc_amt.nil? and self.tier3_max_sc_amt.nil?)
      errors[:base] << "Tier 3 Minimum SC Amount should be less than Maximum SC Amount" if (self.tier3_min_sc_amt.to_f > self.tier3_max_sc_amt.to_f)
    end
  end

  def validate_to_amount
    if !self.tier2_to_amt.nil? and !self.tier1_to_amt.nil?
      errors[:base] << "Tier 2 To Amount should be greater than Tier 1 To Amount" if (self.tier2_to_amt <= self.tier1_to_amt)
    end
  end
end
