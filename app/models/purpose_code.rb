class PurposeCode < ActiveRecord::Base
  audited
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :code, :description, :is_enabled, :txn_limit
  validates_uniqueness_of :code
  validates :code, format: {with: /\A[A-Za-z0-9]+\z/}, length: {maximum: 4, minimum: 4}
  validates :rbi_code, format: {with: /\A[A-Za-z0-9]+\z/}, length: {maximum: 5, minimum: 5}
  validates :txn_limit, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e20'.to_f, :allow_nil => true }
  validates :mtd_txn_cnt_self, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e20'.to_f, :allow_nil => true }
  validates :mtd_txn_limit_self, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e20'.to_f, :allow_nil => true }
  validates :mtd_txn_cnt_sp, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e20'.to_f, :allow_nil => true }
  validates :mtd_txn_limit_sp, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e20'.to_f, :allow_nil => true }
  validate :check_values
  validate :validate_keywords
  before_validation :format_fields

  def validate_keywords
    unless pattern_beneficiaries.nil?
      invalid_values = []
      invalid_spaces = []
      value = self.pattern_beneficiaries.split(/,/)
      invalid_spaces << true if !value.to_s.empty? and value.split(/,/).empty?
      value.each do |val| 
        invalid_spaces << true if val.strip.empty? 
        unless val =~ /\A[A-Za-z0-9\-\(\)\s]+\Z/
          invalid_values << val
        end
      end
      errors.add(:pattern_beneficiaries, "are invalid due to #{invalid_values.join(',')}") unless invalid_values.empty?
      errors.add(:pattern_beneficiaries, "are invalid due to empty values") unless invalid_spaces.empty?
    end
  end

  def format_fields
    self.pattern_beneficiaries = self.pattern_beneficiaries.gsub("\r\n",",") rescue nil
  end

  def formated_pattern_beneficiaries
    pattern_beneficiaries.gsub(",","\r\n") rescue nil
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
