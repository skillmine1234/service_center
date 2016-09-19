class ReconciledReturn < ActiveRecord::Base
  include ReconciledReturnsHelper
  audited
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :txn_type, :return_code, :settlement_date, :bank_ref_no, :reason
  validates_uniqueness_of :bank_ref_no, :scope => [:txn_type]

  before_save :convert_bank_ref_no_to_upcase
  
  def convert_bank_ref_no_to_upcase
    self.bank_ref_no = self.bank_ref_no.upcase unless self.frozen?
  end
  
  def self.options_for_txn_type
    [['NEFT','NEFT'],['RTGS','RTGS'],['IMPS','IMPS']]
  end

end
