class PcCustomerCredential < ActiveRecord::Base
  belongs_to :pc_customer, :foreign_key => 'username', :primary_key => 'email_id', :class_name => 'PcCustomer'
end
