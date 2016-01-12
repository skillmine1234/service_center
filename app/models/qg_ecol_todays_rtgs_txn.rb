class QgEcolTodaysRtgsTxn < ActiveRecord::Base

  validates_presence_of :idfcatref, :transfer_type, :transfer_status, :transfer_unique_no, :rmtr_ref, :bene_account_ifsc, :bene_account_no, :rmtr_account_ifsc, :rmtr_account_no, :transfer_amt, :transfer_ccy, :transfer_date

end
