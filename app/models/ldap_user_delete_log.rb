class LdapUserDeleteLog< ActiveRecord::Base
  self.table_name = 'ldap_user_delete_log'
  include Approval2::ModelAdditions
  #include UserNotification

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
 	def self.enable_approve_button?
        self.approval_status == 'U' ? true : false
     end
end