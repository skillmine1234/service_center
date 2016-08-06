class PcFeeRule < ActiveRecord::Base
  include Approval
  include PcApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  belongs_to :pc_app, :foreign_key => 'app_id', :primary_key => 'app_id', :class_name => 'PcApp'
  
  validates_presence_of :app_id, :txn_kind, :no_of_tiers
  validates_uniqueness_of :app_id, :scope => [:txn_kind, :approval_status]
  validates :tier1_to_amt, :tier1_fixed_amt, :tier1_min_sc_amt, :tier1_max_sc_amt, :tier2_to_amt, :tier2_fixed_amt, :tier2_min_sc_amt, :tier2_max_sc_amt, :tier3_fixed_amt, :tier3_min_sc_amt, :tier3_max_sc_amt, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 9999999999}, :allow_nil => true
  validates :tier1_pct_value, :tier2_pct_value, :tier3_pct_value, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}, :allow_blank => true
  validates :no_of_tiers, :numericality => {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 3 }
  validate :app_id_should_exist
  validate :min_and_max_sc_amt
  
  def self.options_for_txn_kind
    [['loadCard','PcLoadCard'],['payToAccount','PcsPayToAccount'],['payToContact','PcsPayToContact'],['topUp','PcsTopUp']]
  end
  
  def self.options_for_tier_method
    [['Fixed','F'],['Percentage','P']]
  end
  
  def app_id_should_exist
    pc_app = PcApp.find_by(:app_id => self.app_id)
    if pc_app.nil? 
      errors.add(:app_id, "Invalid PcApp")
    end
  end
  
  def min_and_max_sc_amt
    unless (self.tier1_min_sc_amt.nil? and self.tier1_max_sc_amt.nil?)
      errors[:base] << "Tier 1 Minimum SC Amount should be less than Maximum SC Amount" if (self.tier1_min_sc_amt > self.tier1_max_sc_amt)
    end
    unless (self.tier2_min_sc_amt.nil? and self.tier2_max_sc_amt.nil?)
      errors[:base] << "Tier 2 Minimum SC Amount should be less than Maximum SC Amount" if (self.tier2_min_sc_amt > self.tier2_max_sc_amt)
    end
    unless (self.tier3_min_sc_amt.nil? and self.tier3_max_sc_amt.nil?)
      errors[:base] << "Tier 3 Minimum SC Amount should be less than Maximum SC Amount" if (self.tier3_min_sc_amt > self.tier3_max_sc_amt)
    end
  end
end