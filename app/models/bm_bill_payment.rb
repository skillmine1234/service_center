class BmBillPayment < ActiveRecord::Base
  has_many :bm_billpay_steps

  validates_presence_of :app_id, :req_no, :attempt_no, :customer_id, :debit_account_no, :txn_kind,
                        :txn_amount, :status

end