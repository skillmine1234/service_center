class QgEcolTodaysNeftTxn < ArFcr

  validates_presence_of :transfer_unique_no, :rmtr_ref, :bene_account_ifsc, :bene_account_no, :rmtr_account_ifsc, :rmtr_account_no, :transfer_amt, :transfer_date

  validates :bene_account_ifsc, :rmtr_account_ifsc, format: {with: /\A[A-Z|a-z]{4}[0][0-9]{6}+\z/, message: "invalid format - expected format is : {[A-Z|a-z]{4}[0][0-9]{6}}" }  
  validates_uniqueness_of :transfer_unique_no

  before_save :set_default_values
  after_save :set_ref_txn_no

  def set_default_values
    self.transfer_type = 'NEFT'
    self.transfer_ccy = 'INR'
    self.transfer_status = '30'
  end
  
  def set_ref_txn_no
    self.ref_txn_no = self.id
  end

end
