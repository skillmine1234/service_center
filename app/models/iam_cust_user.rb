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
  after_save :add_user_to_ldap# unless Rails.env.development?
  after_save :notify_customer unless Rails.env.test?
  after_save :reset_password unless Rails.env.development?
  
  def generate_password
    if last_action == 'C'
      self.generated_password = Passgen::generate(pronounceable: true, digits_after: 3, length: 10)
      self.encrypted_password = EncPassGenerator.new(generated_password, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_encrypted_password
    end
  end

  def add_user_to_ldap
    LDAP.add_user(username, generated_password) if approval_status == 'A' && last_action == 'C'
  end
  
  def reset_password
    if approval_status == 'A' && should_reset_password == 'Y'
      self.generated_password = Passgen::generate(pronounceable: true, digits_after: 3, length: 10)
      LDAP.reset_password(username, generated_password)
      update_column(:should_reset_password, 'N')
    end
  end

  def notify_customer
    plsql.pk_qg_iam_cust_user.notify(ENV['CONFIG_IIB_SMTP_BROKER_UUID'], self.email, self.mobile_no, self.username, generated_password)
  end
end