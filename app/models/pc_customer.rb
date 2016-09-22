class PcCustomer < ActiveRecord::Base
  belongs_to :app, :foreign_key => 'app_id', :primary_key => 'app_id', :class_name => 'PcApp'
  has_one :pc_customer_credential, :foreign_key => 'username', :primary_key => 'email_id', :class_name => 'PcCustomerCredential'
end
