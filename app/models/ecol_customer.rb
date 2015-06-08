class EcolCustomer < ActiveRecord::Base
  audited
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :code, :name, :val_method, :token_1_type, :token_1_length, :token_2_type,
  :token_2_length, :token_3_type, :token_3_length, :credit_acct_no, :nrtv_sufx_1, :nrtv_sufx_2, :nrtv_sufx_3, :rmtr_alert_on
  
  validates_uniqueness_of :code
  
  validates :code, format: {with: /\A[a-z|A-Z|0-9]{1,15}+\z/}
  validates :name, format: {with: /\A[a-z|A-Z|0-9]{1,15}+\z/}
  validates :credit_acct_no, format: {with: /\A[a-z|A-Z|0-9]{1,25}+\z/}
  validate :cross_field_validations
      
  def cross_field_validations
    if (self.val_method == "N" && (self.val_token_1 != "N" || self.val_token_2 != "N" || self.val_token_3 != "N" || self.val_txn_date != "N" || self.val_txn_amt != "N")) 
      errors[:base] << "If Validation Method is None, then all the Validation Account Tokens should also be None"
    end
    if (self.val_method == "D" && self.file_upld_mthd != "F" && self.file_upld_mthd != "I")
      errors.add(:file_upld_mthd, "Can't be blank if Validation Method is Database Lookup")
    end
    if ((self.token_1_type == self.token_2_type)  || (self.token_2_type == self.token_3_type) || (self.token_1_type == self.token_3_type))
      errors[:base] << "Can't allow same value for all tokens"
    end
    if (((self.nrtv_sufx_1 == self.nrtv_sufx_2) && ((self.nrtv_sufx_1 != "N") && (self.nrtv_sufx_2 != "N"))) || 
      ((self.nrtv_sufx_2 == self.nrtv_sufx_3) && ((self.nrtv_sufx_2 != "N") && (self.nrtv_sufx_3 != "N"))) || 
      ((self.nrtv_sufx_1 == self.nrtv_sufx_3) && ((self.nrtv_sufx_1 != "N") && (self.nrtv_sufx_3 != "N"))))
      errors[:base] << "Can't allow same value for all narration suffixes"
    end
    if ((self.rmtr_alert_on == "P" || self.rmtr_alert_on == "A") && self.rmtr_pass_txt == "")
      errors.add(:rmtr_pass_txt, "Can't be blank if Send Alerts To Remitter On is On Pass or Always")
    end    
    if ((self.rmtr_alert_on == "R" || self.rmtr_alert_on == "A") && self.rmtr_return_txt == "")
      errors.add(:rmtr_return_txt, "Can't be blank if Send Alerts To Remitter On is On Return or Always")
    end
    if (self.nrtv_sufx_1 == "N" && (self.nrtv_sufx_2 != "N" || self.nrtv_sufx_3 != "N"))
      errors[:base] << "If Narrative Suffix 1 is None, then Narrative Suffix 2 & Narrative Suffix 3 should also be None"
    end
    if (self.nrtv_sufx_2 == "N" && self.nrtv_sufx_3 != "N")
      errors[:base] << "If Narrative Suffix 2 is None, then Narrative Suffix 3 also should be None"
    end
  end
end
