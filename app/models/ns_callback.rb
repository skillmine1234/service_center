class NsCallback < ActiveRecord::Base
  include Approval2::ModelAdditions
  
  ALLOWED_HASH_ALGO = 'SHA-256'

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  belongs_to :sc_service
  
  store :setting1, accessors: [:setting1_name, :setting1_type, :setting1_value], coder: JSON
  store :setting2, accessors: [:setting2_name, :setting2_type, :setting2_value], coder: JSON
  store :setting3, accessors: [:setting3_name, :setting3_type, :setting3_value], coder: JSON
  store :setting4, accessors: [:setting4_name, :setting4_type, :setting4_value], coder: JSON
  store :setting5, accessors: [:setting5_name, :setting5_type, :setting5_value], coder: JSON
  
  store :udf1, accessors: [:udf1_name, :udf1_type], coder: JSON
  store :udf2, accessors: [:udf2_name, :udf2_type], coder: JSON
  store :udf3, accessors: [:udf3_name, :udf3_type], coder: JSON
  store :udf4, accessors: [:udf4_name, :udf4_type], coder: JSON
  store :udf5, accessors: [:udf5_name, :udf5_type], coder: JSON

  validates_presence_of :udf1_name, unless: "udf2_name.blank?", message: "can't be blank when Udf2 name is present"
  validates_presence_of :udf2_name, unless: "udf3_name.blank?", message: "can't be blank when Udf3 name is present"
  validates_presence_of :udf3_name, unless: "udf4_name.blank?", message: "can't be blank when Udf4 name is present"
  validates_presence_of :udf4_name, unless: "udf5_name.blank?", message: "can't be blank when Udf5 name is present"

  validates_presence_of :app_code, :sc_service_id, :include_hash
  
  validates_uniqueness_of :app_code, :scope => :approval_status
  
  validates_length_of :app_code, maximum: 50
  validates_length_of :hash_header_name, :hash_algo, :notify_url, maximum: 100, allow_blank: true
  validates_length_of :http_username, :http_password, :hash_key, maximum: 50, allow_blank: true
  
  validates_presence_of :hash_header_name, :hash_algo, :hash_key, if: "include_hash=='Y'"
  validates_absence_of :hash_header_name, :hash_algo, :hash_key, if: "include_hash=='N'"
  validates :hash_header_name, :hash_algo, :hash_key, format: {with: /\A[A-Za-z0-9\s\-\.]+\z/, message: "invalid format - expected format is : {[A-Za-z0-9\s\-\.]}"}, allow_blank: true
  
  before_save :set_settings_cnt, :set_udfs_cnt
  validate :password_should_be_present
  validate :hash_algo_should_be_allowed, if: "hash_algo.present?"
  
  before_save :encrypt_values
  after_save :decrypt_values
  after_find :decrypt_values
  
  private

  def set_settings_cnt
    self.settings_cnt = 0
    self.settings_cnt += 1 unless setting1_name.blank?
    self.settings_cnt += 1 unless setting2_name.blank?
    self.settings_cnt += 1 unless setting3_name.blank?
    self.settings_cnt += 1 unless setting4_name.blank?
    self.settings_cnt += 1 unless setting5_name.blank?
  end
  
  def set_udfs_cnt
    self.udfs_cnt = 0
    self.udfs_cnt += 1 unless udf1_name.blank?
    self.udfs_cnt += 1 unless udf2_name.blank?
    self.udfs_cnt += 1 unless udf3_name.blank?
    self.udfs_cnt += 1 unless udf4_name.blank?
    self.udfs_cnt += 1 unless udf5_name.blank?
  end
  
  def decrypt_values
    self.http_password = DecPassGenerator.new(http_password,ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_decrypted_data if http_password.present?
    self.hash_key = DecPassGenerator.new(hash_key,ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_decrypted_data if hash_key.present?
  end
  
  def encrypt_values
    self.http_password = EncPassGenerator.new(self.http_password, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_encrypted_password unless http_password.to_s.empty?
    self.hash_key = EncPassGenerator.new(self.hash_key, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_encrypted_password unless hash_key.to_s.empty?
  end

  def password_should_be_present
    errors[:base] << "HTTP Password can't be blank if HTTP Username is present" if self.http_username.present? and (self.http_password.blank? or self.http_password.nil?)
  end

  def hash_algo_should_be_allowed
    errors.add(:hash_algo, "Only #{ALLOWED_HASH_ALGO} is allowed") if hash_algo != ALLOWED_HASH_ALGO
  end
  
end