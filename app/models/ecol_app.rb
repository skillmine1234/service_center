class EcolApp < ActiveRecord::Base
  include Approval
  include EcolApproval

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  store :setting1, accessors: [:setting1_name, :setting1_type, :setting1_value], coder: JSON
  store :setting2, accessors: [:setting2_name, :setting2_type, :setting2_value], coder: JSON
  store :setting3, accessors: [:setting3_name, :setting3_type, :setting3_value], coder: JSON
  store :setting4, accessors: [:setting4_name, :setting4_type, :setting4_value], coder: JSON
  store :setting5, accessors: [:setting5_name, :setting5_type, :setting5_value], coder: JSON

  validates_presence_of :app_code
  
  validates_uniqueness_of :app_code, :scope => :approval_status
  
  before_save :set_settings_cnt
  validate :password_should_be_present
  
  before_save :encrypt_password
  after_save :decrypt_password
  after_find :decrypt_password
  
  private

  def set_settings_cnt
    self.settings_cnt = 0
    self.settings_cnt += 1 unless setting1_name.blank?
    self.settings_cnt += 1 unless setting2_name.blank?
    self.settings_cnt += 1 unless setting3_name.blank?
    self.settings_cnt += 1 unless setting4_name.blank?
    self.settings_cnt += 1 unless setting5_name.blank?
  end
  
  def decrypt_password
    self.http_password = DecPassGenerator.new(http_password,ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_decrypted_data if http_password.present?
  end
  
  def encrypt_password
    self.http_password = EncPassGenerator.new(self.http_password, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_encrypted_password unless http_password.to_s.empty?
  end

  def password_should_be_present
    errors[:base] << "HTTP Password can't be blank if HTTP Username is present" if self.http_username.present? and (self.http_password.blank? or self.http_password.nil?)
  end
end