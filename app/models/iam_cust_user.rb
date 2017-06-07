class IamCustUser < ActiveRecord::Base
  include Approval2::ModelAdditions

  attr_accessor :generated_password, :skip_presence_validation

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :username
  validates_presence_of :first_name, :email, :mobile_no, unless: :skip_presence_validation
  validates_uniqueness_of :username, :scope => :approval_status
  validates :mobile_no, numericality: true, length: { maximum: 10 }
  
  before_save :generate_password
  after_save :add_user_to_ldap_on_approval unless Rails.env.development?
  after_save :delete_user_from_ldap_on_approval unless Rails.env.development?

  def template_variables
    {username: username, first_name: first_name, last_name: last_name, mobile_no: mobile_no, email: email, password_part_1: decrypted_password, password_part_2: decrypted_password}
  end
  
  def will_connect_to_ldap
    LDAP.ldap
    return nil
  rescue LDAPFault, Psych::SyntaxError, SystemCallError, Net::LDAP::LdapError => e
    errors[:base] << "LDAP connection error : #{e.message}"
  end
  
  def test_ldap_login
    LDAP.try_login(username, decrypted_password)
    "Login Successful"
  rescue LDAPFault, Psych::SyntaxError, SystemCallError, Net::LDAP::LdapError => e
    e.message
  end
  
  def resend_password
    notify_customer('Password Generated')
    "Email has been sent!"
  rescue OCIError, ArgumentError => e
    e.message
  end
  
  def add_user_to_ldap
    LDAP.add_user(username, decrypted_password)
    notify_customer('Password Generated') unless Rails.env.test?
    "Entry added successfully to LDAP for #{username}!"
  rescue LDAPFault, Psych::SyntaxError, SystemCallError, Net::LDAP::LdapError, OCIError, ArgumentError => e
    e.message
  end

  def add_user_to_ldap_on_approval
    if approval_status == 'A' && last_action == 'C'
      LDAP.add_user(username, generated_password)
      update_column(:was_user_added, 'Y')
      notify_customer('Password Generated') unless Rails.env.test?
    end
  rescue
    nil
  end

  def delete_user_from_ldap
    if is_enabled == 'N'
      LDAP.delete_user(username)
      notify_customer('Access Removed')
      "Entry deleted from LDAP for #{username}!"
    end
  rescue LDAPFault, Psych::SyntaxError, SystemCallError, Net::LDAP::LdapError, OCIError, ArgumentError => e
    e.message
  end

  def delete_user_from_ldap_on_approval
    if approval_status == 'A' && is_enabled == 'N' && is_enabled_was == 'Y'
      LDAP.delete_user(username)
      notify_customer('Access Removed')
    end
  rescue
    nil
  end
  
  def generate_password
    if last_action == 'C' || ( approval_status == 'A' && should_reset_password == 'Y' )
      self.generated_password = Passgen::generate(pronounceable: true, digits_after: 3, length: 10)
      self.encrypted_password = EncPassGenerator.new(generated_password, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_encrypted_password
      unless last_action ==  'C'
        self.should_reset_password = 'N'
        self.last_password_reset_at = Time.zone.now
      end
    end
  end

  def notify_customer(event)
    event = ScEvent.find_by_event(event)
    template = NsTemplate.find_by_ns_event_id(event.id) rescue nil
    unless template.nil?
      plsql.pk_qg_send_email.enqueue1(ENV['CONFIG_IIB_SMTP_BROKER_UUID'], self.email, NsTemplate.render_template(template.email_subject, template_variables), NsTemplate.render_template(template.email_body, template_variables)) unless template.email_body.to_s.empty?
      plsql.pk_qg_send_sms.enqueue(ENV['CONFIG_IIB_SMTP_BROKER_UUID'], self.mobile_no, NsTemplate.render_template(template.sms_text, template_variables)) unless template.sms_text.to_s.empty?
      update_column(:notification_sent_at, Time.zone.now)
    end
  end
  
  def decrypted_password
    DecPassGenerator.new(encrypted_password,ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_decrypted_data
  end
end