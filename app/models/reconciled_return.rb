class ReconciledReturn < ActiveRecord::Base
  include ReconciledReturnsHelper
  audited
  
  RET_CODE_TYPE = %w(COMPLETED FAILED)
  attr_accessor :return_code_type
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  before_validation :set_return_code

  validates_presence_of :txn_type, :return_code_type, :return_code, :settlement_date, :bank_ref_no, :reason
  validates_uniqueness_of :bank_ref_no, :scope => [:txn_type]

  before_save :convert_bank_ref_no_to_upcase
  
  def convert_bank_ref_no_to_upcase
    self.bank_ref_no = self.bank_ref_no.upcase unless self.frozen?
  end
  
  def self.options_for_txn_type
    [['NEFT','NEFT'],['RTGS','RTGS'],['IMPS','IMPS']]
  end

  def set_return_code
    case txn_type
    when 'NEFT'
      if return_code_type == 'COMPLETED'
        self.return_code = '75'
      else
        self.return_code = '99'
      end
    when 'RTGS' 
      if return_code_type == 'COMPLETED'
        self.return_code = 'COM'
      else
        self.return_code = 'REJ'
      end
    when 'IMPS'
      if return_code_type == 'COMPLETED'
        self.return_code = '00'
      else
        self.return_code = '08'
      end
    end
  end
end
