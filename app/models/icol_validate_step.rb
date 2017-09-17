class IcolValidateStep < ActiveRecord::Base
  lazy_load :up_req_header, :up_rep_header, :up_req_bitstream, :up_rep_bitstream, :req_bitstream, :rep_bitstream, :fault_bitstream
  
  belongs_to :icol_customer, foreign_key: 'customer_code', primary_key: 'customer_code', class_name: 'IcolCustomer'
end
