class EcolTransaction < ActiveRecord::Base
  has_one :ecol_customer, :primary_key => 'customer_code', :foreign_key => 'code'
  has_one :ecol_remitter, :primary_key => 'ecol_remitter_id', :foreign_key => 'id'
  
  validates_presence_of :status, :transfer_type, :transfer_unique_no, :transfer_status, 
  :transfer_date, :transfer_ccy, :transfer_amt, :rmtr_account_no, :rmtr_account_ifsc,
  :bene_account_no, :bene_account_ifsc, :received_at
  
  validates :transfer_amt, :numericality => { :greater_than => 0 }
  
end