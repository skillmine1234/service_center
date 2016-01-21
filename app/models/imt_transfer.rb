class ImtTransfer < ActiveRecord::Base
  has_one :imt_customer, :primary_key => "customer_id", :foreign_key => "id"
end