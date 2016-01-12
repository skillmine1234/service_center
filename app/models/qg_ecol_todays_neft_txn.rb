class QgEcolTodaysNeftTxn < ActiveRecord::Base

  self.primary_key = 'ref_txn_no'

  validates_presence_of :ref_txn_no, :transfer_type, :transfer_status, :transfer_unique_no, :rmtr_ref, :bene_account_ifsc, :bene_account_no, 
  :rmtr_account_ifsc, :rmtr_account_no, :transfer_amt, :transfer_ccy, :transfer_date

  [:bene_account_ifsc, :rmtr_account_ifsc].each do |column|
    validates column, format: {with: /\A[A-Z|a-z]{4}[0][A-Za-z0-9]{6}+\z/, message: "invalid format - expected format is : {[A-Z|a-z]{4}[0][A-Za-z0-9]{6}}" }
  end

  before_create :set_default_values

  def set_default_values
    self.transfer_type = 'NEFT'
    self.transfer_ccy = 'INR'
    self.transfer_status = '30'
  end

end
