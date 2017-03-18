require 'net/ldap'
require 'yaml'

class LDAPFault < StandardError
  attr_reader :operation, :code, :message
  def initialize(operation, code, message)
    @operation = operation
    @code = code
    @message = message
  end
end

class LDAP
  def self.config
    raise LDAPFault.new(nil, nil, 'IAM_LDAP_CONFIG_FILE_PATH config variable is not set') if ENV['IAM_LDAP_CONFIG_FILE_PATH'].blank?
    raise LDAPFault.new(nil, nil, "No such file or directory : #{ENV['IAM_LDAP_CONFIG_FILE_PATH']}") unless File.exists? (ENV['IAM_LDAP_CONFIG_FILE_PATH'])

    data = YAML.load_file(ENV['IAM_LDAP_CONFIG_FILE_PATH'])['data']
    raise LDAPFault.new(nil, nil, "Cannot connect to LDAP since data setup in #{ENV['IAM_LDAP_CONFIG_FILE_PATH']} is inclomplete") if (data['ssl'].blank? || data['host'].blank? || 
                        data['port'].blank? || data['admin_user'].blank? || data['admin_password'].blank? || data['base'].blank? || data['required_group'].blank? )
    data
  end

  def self.ldap
    l = Net::LDAP.new
    l.encryption(config['ssl']) if config['ssl'] == :simple_tls
    l.host = config['host']
    l.port = config['port']

    @admin_user = config['admin_user']
    @admin_password = config['admin_password']

    @base = config['base']
    @required_group = config['required_group']

    l.auth  @admin_user, @admin_password

    raise LDAPFault.new(nil, nil, 'LDAP : Failed to bind') if l.bind == false
    
    return l
  end

  def self.add_user(username, password)
     dn = "CN=#{username},#{@base}"

     attr = {
        :objectclass => ["top", "person", "organizationalPerson", "user"],
        :sAMAccountName => "#{username}",
        :unicodePwd => str2unicodePwd(password),
        :userAccountControl => "66048"
     }
     ldap.add(:dn => dn, :attributes => attr)
     ldap_result = ldap.get_operation_result 
     raise LDAPFault.new('add user', ldap_result.code, ldap_result.message) if ldap_result.code != 0

     ldap.modify(:dn => @required_group, :operations => [[:add, :member, dn]])
     ldap_result = ldap.get_operation_result 
     raise LDAPFault.new('add group', ldap_result.code, ldap_result.message) if ldap_result.code != 0
  end

  def self.delete_user(username)
     dn = "CN=#{username},#{@base}"

     ldap.delete :dn => dn
     ldap_result = ldap.get_operation_result 
     raise LDAPFault.new('delete user', ldap_result.code, ldap_result.message) if ldap_result.code != 0
  end

  def self.change_password(username, old_password, new_password)
     dn = "CN=#{username},#{@base}"
 
     raise  LDAPFault.new('change password', -1, 'invalid user/password') if !login(username, old_password)

     reset_password(username, new_password)
  end

  def self.reset_password(username, new_password)
     dn = "CN=#{username},#{@base}"

     ldap.modify(:dn => dn, :operations => [[:replace, :unicodePwd, str2unicodePwd(new_password)]])
     ldap_result = ldap.get_operation_result 
     raise LDAPFault.new('delete user', ldap_result.code, ldap_result.message) if ldap_result.code != 0
  end

  def self.login(username, password)
    ldap.auth username, password
    ldap.bind
    true
  rescue => e
     false
  ensure
    ldap.auth  @admin_user, @admin_password
  end

  private
  def self.str2unicodePwd(str)
    ('"' + str + '"').encode('utf-16le').force_encoding('utf-8')
  end

end
