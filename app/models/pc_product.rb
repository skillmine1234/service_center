class PcProduct < ActiveRecord::Base
  include Approval
  include PcApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :code, :mm_host, :mm_consumer_key, :mm_consumer_secret, :mm_card_type, :mm_email_domain, :mm_admin_host, :mm_admin_user, :mm_admin_password,
                        :card_acct, :sc_gl_income, :cust_care_no, :rkb_user, :rkb_password, :rkb_bcagent, :rkb_channel_partner
  
  validates :code, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: { minimum: 1,  maximum: 6 }
  validates :mm_host, :mm_admin_host , format: { with: URI.regexp , :message => 'Please enter a valid host, Eg: http://example.com'}
  validates :mm_consumer_key, :mm_consumer_secret, :mm_card_type, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => "Invalid format, expected format is : {[a-z|A-Z|0-9]}" }
  validates :mm_email_domain, format: {with: /\A[a-z|A-Z|\.]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|\.]}' }
  validates :card_acct, :sc_gl_income, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => "Invalid format, expected format is : {[a-z|A-Z|0-9]}" }
  validates :display_name, format: {with: /\A[a-z|A-Z|0-9|\s|\.|\-]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\s|\.|\-]}' }, length: { minimum: 1 }, allow_blank: true
  validates :cust_care_no, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9|]}' }, length: { minimum: 4,  maximum: 16 }
  validates :rkb_user, :rkb_password, :rkb_bcagent, :rkb_channel_partner, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => "Invalid format, expected format is : {[a-z|A-Z|0-9]}" }

  validates :mm_card_type, :mm_admin_user, :mm_admin_password, length: { maximum: 50 }
  validates :card_acct, length: { minimum: 10, maximum: 20 }
  validates :sc_gl_income, length: { minimum: 3, maximum: 15 }

  validates :rkb_user, length: { maximum: 30 }
  validates :rkb_password, length: { maximum: 40 }
  validates :rkb_bcagent, length: { maximum: 50 }
  validates :rkb_channel_partner, length: { maximum: 3 }

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
