class PurposeCode < ActiveRecord::Base
  include Approval
  include InwApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :code, :description, :is_enabled, :txn_limit
  validates_uniqueness_of :code, :scope => :approval_status
  validates :code, format: {with: /\A[A-Za-z0-9]+\z/}, length: {maximum: 4, minimum: 4}
  validates :rbi_code, format: {with: /\A[A-Za-z0-9]+\z/}, length: {maximum: 5, minimum: 5}, :allow_blank => true
  validates :txn_limit, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e20'.to_f, :allow_nil => true }
  validates :mtd_txn_cnt_self, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e20'.to_f, :allow_nil => true }
  validates :mtd_txn_limit_self, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e20'.to_f, :allow_nil => true }
  validates :mtd_txn_cnt_sp, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e20'.to_f, :allow_nil => true }
  validates :mtd_txn_limit_sp, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e20'.to_f, :allow_nil => true }
  validate :check_values

  validates_format_of :pattern_beneficiaries, :pattern_remitters, :with => /\A\w[\w\-\(\)\s\r\n]*\z/, :allow_blank => true
  before_validation :squish_patterns

  def squish_patterns
    self.pattern_beneficiaries = pattern_beneficiaries.squeeze(' ').strip.each_line.reject{|x| x.strip == ''}.join unless pattern_beneficiaries.nil?
    self.pattern_remitters = pattern_remitters.squeeze(' ').strip.each_line.reject{|x| x.strip == ''}.join unless pattern_remitters.nil?
  end

  def check_values
    if !mtd_txn_limit_self.nil? and !txn_limit.nil? and !mtd_txn_limit_sp.nil?
      errors.add(:mtd_txn_limit_self,"is less than transaction limit") unless mtd_txn_limit_self >= txn_limit.to_f
      errors.add(:mtd_txn_limit_sp,"is less than transaction limit") unless mtd_txn_limit_sp >= txn_limit.to_f
    end
  end

  def self.options_for_bene_and_rem_types
    [['Individual','I'],['Corporates','C']]
  end
  
  def convert_disallowed_bene_types_to_string(value)
    if (value.is_a? Array)
      value.reject!(&:blank?)
      self.disallowed_bene_types=value.join(',')
    else 
      ""
    end
  end 
  
  def convert_disallowed_rem_types_to_string(value)
    if (value.is_a? Array)
      value.reject!(&:blank?)
      self.disallowed_rem_types=value.join(',')
    else 
      ""
    end
  end  

end