class IcInvoice < ActiveRecord::Base
  belongs_to :ic_customer, :foreign_key =>'corp_customer_id', :primary_key => 'customer_id', :class_name => 'IcCustomer'
end
