class EcolTransaction < ActiveRecord::Base
  has_one :ecol_customer, :primary_key => 'customer_code', :foreign_key => 'code'
  has_one :ecol_remitter, :primary_key => 'ecol_remitter_id', :foreign_key => 'id'
  has_many :credit_logs, -> { where :step_name => 'CREDIT' }, :class_name => 'EcolAuditLog'
  has_many :return_logs, -> { where :step_name => 'RETURN' }, :class_name => 'EcolAuditLog'
  has_many :settle_logs, -> { where :step_name => 'SETTLE' }, :class_name => 'EcolAuditLog'
  has_many :notify_logs, -> { where :step_name => 'NOTIFY' }, :class_name => 'EcolAuditLog'
  
  validates_presence_of :status, :transfer_type, :transfer_unique_no, :transfer_status, 
  :transfer_date, :transfer_ccy, :transfer_amt, :rmtr_account_no, :rmtr_account_ifsc,
  :bene_account_no, :bene_account_ifsc, :received_at
  
  validates :transfer_amt, :numericality => { :greater_than => 0 }
  
end
