class IamOrganisation < ActiveRecord::Base
  include Approval2::ModelAdditions

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  before_validation :squish_ips
  
  validates_presence_of :name, :org_uuid, :on_vpn, :is_enabled
  validates_uniqueness_of :org_uuid, :scope => :approval_status
  validates :on_vpn, length: { minimum: 1, maximum: 1 }
  validates_format_of :source_ips, :with => /\A\w[\w\-\(\)\.\s\r\n]*\z/, :allow_blank => true
  validate :value_of_source_ips

  validates_presence_of :cert_dn, :message => "Required when 'Is VPN On?' is not selected.", :if => '!is_vpn_on?'
  validates_presence_of :source_ips, :message => "Required when 'Is VPN On?' is selected.", :if => 'is_vpn_on?'

  def is_vpn_on?
    on_vpn == 'Y' ? true : false
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
    self.source_ips = source_ips.squeeze(' ').strip.each_line.reject{|x| x.strip == ''}.join if (!self.frozen? and !source_ips.nil?)
  end
end