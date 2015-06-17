class EcolTransaction < ActiveRecord::Base
  
  validates_presence_of :status, :transfer_type, :transfer_unique_no, :transfer_status, 
  :transfer_date, :transfer_ccy, :transfer_amt, :rmtr_account_no, :rmtr_account_ifsc,
  :bene_account_no, :bene_account_ifsc, :received_at
  
end
