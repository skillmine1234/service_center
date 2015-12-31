class FpAuthRule < ActiveRecord::Base
  include Approval
  include FpApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  before_validation :squish_ips
  
  validates_presence_of :operation_name, :username
  validates_uniqueness_of :username, :scope => [:approval_status]
  
  validates_format_of :source_ips, :with => /\A\w[\w\-\(\)\.\s\r\n]*\z/, :allow_blank => true
  validate :presence_of_source_ips, :value_of_source_ips
  
  def self.operation_names_list
    FpOperation.all.map {|u| [u.operation_name, u.operation_name]}
  end
  
  def convert_operation_name_to_string(value)
    if (value.is_a? Array)
      value.reject!(&:blank?)
      self.operation_name = value.join(', ')
    else 
      ""
    end
  end 
  
  def self.convert_options_to_array(options_as_string)
    if (!options_as_string.nil?) && (options_as_string != '*')
      options_as_string.split(',')
    else 
      []
    end
  end
  
  def presence_of_source_ips
    if self.any_source_ip == 'N' and self.source_ips.empty? 
      errors.add(:source_ips, "Source IPs is mandatory")
    end
  end
  
  def value_of_source_ips
    unless self.source_ips.nil?
      arr =  self.source_ips.split(' ')
      invalid_ips = []
      arr.each do |a|
        if (Resolv::IPv4::Regex =~ a) == nil
          invalid_ips << a
        end
      end
      errors.add(:source_ips, "Invalid IPs #{invalid_ips}") unless invalid_ips.empty?
    end
  end
    
  def squish_ips
    self.source_ips = source_ips.squeeze(' ').strip.each_line.reject{|x| x.strip == ''}.join unless source_ips.nil?
  end
  
end