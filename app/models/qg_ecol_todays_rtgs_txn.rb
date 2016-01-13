class QgEcolTodaysRtgsTxn < ArFcatrt

  validates_presence_of :idfcatref, :transfer_type, :transfer_status, :transfer_unique_no, :rmtr_ref, :bene_account_ifsc, :bene_account_no, 
  :rmtr_account_ifsc, :rmtr_account_no, :transfer_amt, :transfer_ccy, :transfer_date

  validates :bene_account_ifsc, :rmtr_account_ifsc, format: {with: /\A[A-Z|a-z]{4}[0][0-9]{6}+\z/, message: "invalid format - expected format is : {[A-Z|a-z]{4}[0][0-9]{6}}" }

  validates :transfer_amt, :numericality => { :greater_than_or_equal_to => 200000 }
  validates_uniqueness_of :transfer_unique_no

  before_create :set_default_values  
  after_save :set_idfcatref

  def set_default_values
    self.transfer_type = 'RTGS'
    self.transfer_ccy = 'INR'
    self.transfer_status = 'COM'
  end
  
  def set_idfcatref
    self.idfcatref = self.id
  end

end
