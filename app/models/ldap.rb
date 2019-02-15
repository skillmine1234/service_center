require 'net/ldap'
require 'yaml'

class LDAPFault < StandardError
  attr_reader :operation, :code, :message
  def initialize(operation, result)
    @operation = operation
    if result.is_a?(String)
      @message = result
    else
      @code = result.code
      @message = "#{result.message} : #{result.error_message}"
    end
  end
end

class LDAP
  def read_config
    raise LDAPFault.new('read_config', 'IAM_LDAP_CONFIG_FILE_PATH config variable is not set') if ENV['IAM_LDAP_CONFIG_FILE_PATH'].blank?
    raise LDAPFault.new('read_config', "No such file or directory : #{ENV['IAM_LDAP_CONFIG_FILE_PATH']}") unless File.exists? (ENV['IAM_LDAP_CONFIG_FILE_PATH'])
    data = YAML.load_file(ENV['IAM_LDAP_CONFIG_FILE_PATH'])['ldap']
    raise LDAPFault.new('read_config', "Cannot connect to LDAP since data setup in #{ENV['IAM_LDAP_CONFIG_FILE_PATH']} is inclomplete") if (data['ssl'].blank? || data['host'].blank? ||
                        data['port'].blank? || data['admin_user'].blank? || data['admin_password'].blank? || data['base'].blank? )
    data
  end

  def initialize
    @ldap = Net::LDAP.new

    config = read_config
    @ldap.encryption(config['ssl']) if config['ssl'] == :simple_tls
    @ldap.host = config['host']
    @ldap.port = config['port']

    @base = config['base']
    @required_group = config['required_group']

    @admin_user = "CN=#{config['admin_user']},#{@base}"
    @admin_password = config['admin_password']

    @ldap_kind = config['kind']

    @ldap.auth  @admin_user, @admin_password
    @ldap_bind = @ldap.bind
    Rails.logger.info "===========ldap bind response===========================" if ENV['LDAP_LOGGERS_ENABLED'] == "true" rescue nil
    Rails.logger.info @ldap_bind.inspect rescue nil
    Rails.logger.info "================================================" if ENV['LDAP_LOGGERS_ENABLED'] == "true" rescue nil
    raise LDAPFault.new(nil, @ldap.get_operation_result) if @ldap_bind == false
  end

  def add_user(username, password)

    Rails.logger.info "===========ldap object===========================" if ENV['LDAP_LOGGERS_ENABLED'] == "true" rescue nil
    Rails.logger.info @ldap.inspect if ENV['LDAP_LOGGERS_ENABLED'] == "true" rescue nil
    Rails.logger.info "================================================" if ENV['LDAP_LOGGERS_ENABLED'] == "true" rescue nil

    Rails.logger.info "===========config object===========================" if ENV['LDAP_LOGGERS_ENABLED'] == "true" rescue nil
    Rails.logger.info config.inspect if ENV['LDAP_LOGGERS_ENABLED'] == "true"  rescue nil
    Rails.logger.info "================================================" if ENV['LDAP_LOGGERS_ENABLED'] == "true" rescue nil


     dn = "CN=#{username},#{@base}"

     ad_attr = {
        :objectclass => ["top", "person", "organizationalPerson", "user"],
        :sAMAccountName => "#{username}",
        :unicodePwd => str2unicodePwd(password),
        :userAccountControl => "66048"
     }
     ol_attr = {
        :objectclass => ["top", "person", "organizationalPerson"],
        :sn => "#{username}",
        :userPassword => password
     }

     if @ldap_kind == 'openldap'
       res = @ldap.add(:dn => dn, :attributes => ol_attr)
       Rails.logger.info "============ldap add response in open ldap ========ldap_kind=#{@ldap_kind}============" if ENV['LDAP_LOGGERS_ENABLED'] == "true"  rescue nil
       Rails.logger.info res.inspect if ENV['LDAP_LOGGERS_ENABLED'] == "true"  rescue nil
       Rails.logger.info " =================================" if ENV['LDAP_LOGGERS_ENABLED'] == "true"  rescue nil
       res
     else
       res = @ldap.add(:dn => dn, :attributes => ad_attr)
       Rails.logger.info "============ldap add response in other ldap kind ==========ldap_kind=#{@ldap_kind}===========" if ENV['LDAP_LOGGERS_ENABLED'] == "true"  rescue nil
       Rails.logger.info res.inspect if ENV['LDAP_LOGGERS_ENABLED'] == "true"  rescue nil
       Rails.logger.info " =========================================" if ENV['LDAP_LOGGERS_ENABLED'] == "true"  rescue nil
       res
     end

     ldap_result = @ldap.get_operation_result

     Rails.logger.info "============ldap result after adding===========" if ENV['LDAP_LOGGERS_ENABLED'] == "true"  rescue nil
     Rails.logger.info ldap_result.inspect if ENV['LDAP_LOGGERS_ENABLED'] == "true"  rescue nil
     Rails.logger.info " =========================================" if ENV['LDAP_LOGGERS_ENABLED'] == "true"  rescue nil

     raise LDAPFault.new('add user', ldap_result) if ldap_result.code != 0

     ldap_result

     unless @required_group.blank?
       @ldap.modify(:dn => @required_group, :operations => [[:add, :member, dn]])
       ldap_result = @ldap.get_operation_result
       Rails.logger.info "============ldap result if required group is blank===========" if ENV['LDAP_LOGGERS_ENABLED'] == "true"  rescue nil
       Rails.logger.info ldap_result.inspect if ENV['LDAP_LOGGERS_ENABLED'] == "true"  rescue nil
       Rails.logger.info " =========================================" if ENV['LDAP_LOGGERS_ENABLED'] == "true"  rescue nil
       raise LDAPFault.new('add group', ldap_result) if ldap_result.code != 0
     end
  end

  def delete_user(username)
     dn = "CN=#{username},#{@base}"

     @ldap.delete :dn => dn
     ldap_result = @ldap.get_operation_result
     raise LDAPFault.new('delete user', ldap_result) if ldap_result.code != 0
  end

  def change_password(username, old_password, new_password)
     dn = "CN=#{username},#{@base}"

     raise  LDAPFault.new('change password', 'invalid user/password') if !login(username, old_password)

     reset_password(username, new_password)
  end

  def reset_password(username, new_password)
     dn = "CN=#{username},#{@base}"

     if @ldap_kind == :openldap
       @ldap.modify(:dn => dn, :operations => [[:replace, :userPassword, new_password]])
     else
       @ldap.modify(:dn => dn, :operations => [[:replace, :unicodePwd, str2unicodePwd(new_password)]])
     end
     ldap_result = @ldap.get_operation_result
     raise LDAPFault.new('reset password', ldap_result) if ldap_result.code != 0
  end

  def try_login(username, password)
    dn = "CN=#{username},#{@base}"
    @ldap.auth dn, password
    raise LDAPFault.new(nil, @ldap.get_operation_result) if @ldap.bind == false
  end

  private
  def str2unicodePwd(str)
    ('"' + str + '"').encode('utf-16le').force_encoding('utf-8')
  end

  def login(username, password)
    try_login(username, password)
    true
  rescue => e
    false
  ensure
    @ldap.auth  @admin_user, @admin_password
  end
end
