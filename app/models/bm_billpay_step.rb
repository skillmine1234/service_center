class BmBillpayStep < ActiveRecord::Base
  belongs_to :bm_bill_payment

  validates_presence_of :bm_bill_payment_id, :step_no, :attempt_no, :step_name, :status_code

end