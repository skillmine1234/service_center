class IamCustUser < ActiveRecord::Base
  include Approval2::ModelAdditions
  include UserNotification

  attr_accessor :generated_password, :skip_presence_validation

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :username
  validates_presence_of :first_name, :email, :mobile_no, unless: :skip_presence_validation
  validates_uniqueness_of :username, :scope => :approval_status
  validates :mobile_no, numericality: true, length: { maximum: 20 }
  validates_length_of :username, :first_name, :last_name, maximum: 100
  validates_format_of :username, with: /\A[a-z|A-Z|0-9|\_|\.]+\z/, message: "invalid format - expected format is : {[a-z|A-Z|0-9|\_|\.]}"
  validates_format_of :first_name, with: /\A[a-z|A-Z|0-9|\s|\.|\-]+\z/, message: "invalid format - expected format is : {[a-z|A-Z|0-9|\s|\.|\-]}"
  validates_format_of :last_name, with: /\A[a-z|A-Z|0-9|\s|\.|\-]+\z/, message: "invalid format - expected format is : {[a-z|A-Z|0-9|\s|\.|\-]}", allow_blank: true
  validates :email, format: {with: Devise::email_regexp}, length: { maximum: 100 }

  before_save :generate_password

  def template_variables(event)
    if event == 'Password Generated'
      { username: username, first_name: first_name, last_name: last_name, mobile_no: mobile_no, email: email, password_part_1: password_part_1(decrypted_password), password_part_2: password_part_2(decrypted_password) }
    elsif event == 'Access Removed'
      { username: username, first_name: first_name, last_name: last_name, mobile_no: mobile_no, email: email }
    end
  end

  def password_part_1(passwd)
    passwd.slice(0..(passwd.length/2)-1)
  end

  def password_part_2(passwd)
    passwd.slice((passwd.length/2)..passwd.length)
  end
  
  def will_connect_to_ldap
    LDAP.new
    return nil
  rescue LDAPFault, Psych::SyntaxError, SystemCallError, Net::LDAP::LdapError => e
    errors[:base] << "LDAP connection error : #{e.message}"
  end
  
  def generate_password
    if last_action == 'C' || ( approval_status == 'A' && should_reset_password == 'Y' )
      self.generated_password = [*('A'..'Z')].sample(4).join + rand(10..99).to_s + [*('a'..'z')].sample(4).join
      self.encrypted_password = EncPassGenerator.new(generated_password, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_encrypted_password
      unless last_action ==  'C'
        self.should_reset_password = 'N'
        self.last_password_reset_at = Time.zone.now
        notify_customer('Password Generated')
      end
    end
  end
  
  def decrypted_password
    DecPassGenerator.new(encrypted_password,ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_decrypted_data
  end
  
  def self.iam_cust_user_exists?(*args)
    args.size.zero? ? true : IamCustUser.find_by(username: args[0]).present?
  end
end