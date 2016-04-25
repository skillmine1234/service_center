class EncPassGenerator

  def initialize(password_string, key, secret)
    @password_string = password_string
    @key = key
    @secret = secret
  end

  def generate_encrypted_password
    encrypt_password(@password_string, @key, @secret)
  end

  ALGO = 'AES-128-CBC'

  private
  def encrypt_password(password_string, consumer_key, consumer_secret)
    require 'openssl'
    require 'base64'

    # this creates the key, and the cipher
    secret = OpenSSL::PKCS5.pbkdf2_hmac_sha1(consumer_secret, consumer_key, 1024, 128)
    cipher = OpenSSL::Cipher::Cipher.new(ALGO)
    cipher.encrypt
    iv = cipher.random_iv
    cipher.key = secret
    cipher.iv = iv

    # the following does the encryption
    encrypted_data = cipher.update(password_string)
    encrypted_data << cipher.final

    # the encrypted string & the IV (concatenated by --) is to be sent across to the ESB
    encrypted_password = [encrypted_data, iv].map {|v| Base64.strict_encode64(v)}.join("--")
    return encrypted_password
  end

end