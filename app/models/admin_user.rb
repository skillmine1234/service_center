class AdminUser < ActiveRecord::Base
  rolify :role_cname => 'AdminRole'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :password_expirable,
         :rememberable, :trackable, :validatable, :timeoutable, :session_limitable

  validates :username,
  :uniqueness => {
    :case_sensitive => false
  }

  def name
    username
  end

end
