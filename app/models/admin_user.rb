class AdminUser < ActiveRecord::Base
  rolify :role_cname => 'AdminRole'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  if ENV['DEVISE_AUTHENTICATE_WITH_LDAP'] == "true"
    devise :ldap_authenticatable, :trackable
    before_create :get_ldap_name
  else
  devise :database_authenticatable, :password_expirable,
         :rememberable, :trackable, :validatable, :timeoutable, :session_limitable
  end       

  validates :username,
  :uniqueness => {
    :case_sensitive => false
  }

  def name
    username
  end

  def get_ldap_name
    self.last_name = Devise::LdapAdapter.get_ldap_param(self.username, 'sn') rescue nil
    self.email = Devise::LdapAdapter.get_ldap_param(self.username, 'mail') rescue "#{username}@ratnakarbank.in"
    self.mobile_no = Devise::LdapAdapter.get_ldap_param(self.username, 'mobile') rescue nil
    if self.last_name.blank?
      errors.add(:username, "Invalid User Id")
      return false
    elsif self.first_name.blank?
      self.first_name = Devise::LdapAdapter.get_ldap_param(self.username, 'givenname') rescue nil
      errors.add(:username, "User Name: #{self.first_name} #{self.last_name}, Kindly validate name before creation.")
      return false
    end
    return true
  end
  
end
