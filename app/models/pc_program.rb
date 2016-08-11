class PcProgram < ActiveRecord::Base
  include Approval
  include PcApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :code, :mm_host, :mm_consumer_key, :mm_consumer_secret, :mm_card_type, :mm_email_domain, :mm_admin_host, :mm_admin_user, :mm_admin_password
  
  validates :code, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: {maximum: 15}
  validates :mm_host, :mm_admin_host , format: { with: URI.regexp , :message => 'Please enter a valid host, Eg: http://example.com'}
  validates :mm_consumer_key, :mm_consumer_secret, :mm_card_type, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => "Invalid format, expected format is : {[a-z|A-Z|0-9]}" }
  validates :mm_email_domain, format: {with: /\A[a-z|A-Z|\.]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|\.]}' }

  validates_uniqueness_of :code, :scope => :approval_status

  def self.options_for_pc_programs
    PcProgram.all.collect { |pc_program| [pc_program.code, pc_program.code] }
  end

  before_save :to_downcase

  before_save :encrypt_password

  def encrypt_password
    unless self.frozen?
      if approval_status == 'U'
        self.mm_admin_password = EncPassGenerator.new(self.mm_admin_password, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_encrypted_password unless self.mm_admin_password.to_s.empty?
      end
    end
  end

  def to_downcase
    unless self.frozen?
      self.code = self.code.downcase unless self.code.nil?
    end
  end
end
