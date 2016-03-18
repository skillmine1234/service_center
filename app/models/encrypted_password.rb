class EncryptedPassword < ActiveRecord::Base
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'

  # the consumer key & consumer password will change across environments , keep it configurable, and secret
  CONSUMER_KEY = '0me5MQjVJZb4icLjUGOoIyLzTs8sleB2'
  CONSUMER_SECRET = 'udFqnMBlgJhRKrBDSXjEp1OHPjdSkxEnAXHdyDynH0R7GnzdUU2kZOSNf416aa3Q'

  # the encryption method, this cannot be changed without a corresponding change on the ESB
  ALGO = 'AES-128-CBC'

  before_save :encrypt_password
  
  def encrypt_password
    encrypted_password = EncryptedPassword.apply_encryption(password)
    self.password = encrypted_password
  end

  def self.apply_encryption(password)
    require 'openssl'
    require 'base64'

    # this creates the key, and the cipher
    secret = OpenSSL::PKCS5.pbkdf2_hmac_sha1(CONSUMER_SECRET, CONSUMER_KEY, 1024, 128)
    cipher = OpenSSL::Cipher::Cipher.new(ALGO)
    cipher.encrypt
    iv = cipher.random_iv
    cipher.key = secret
    cipher.iv = iv

    # the following does the encryption
    encrypted_data = cipher.update(password)
    encrypted_data << cipher.final

    # the encrypted string & the IV (concatenated by --) is to be sent across to the ESB
    result = [encrypted_data, iv].map {|v| Base64.strict_encode64(v)}.join("--")
    return result
  end

end
