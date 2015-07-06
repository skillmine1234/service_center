module EcolCustomerValidation
  extend ActiveSupport::Concern
  included do
    validate :val_tokens_should_be_N_if_val_method_is_N,
    :file_upld_mthd_is_mandatory_if_val_method_is_D,
    :same_value_cannot_be_selected_for_all_acct_tokens,
    :acct_token_2_and_3_should_be_N_if_acct_token_1_is_N,
    :acct_token_3_should_be_N_if_acct_toekn_2_is_N,
    :same_value_cannot_be_selected_for_all_nrtv_sufxs,
    :rmtr_pass_txt_is_mandatory_if_rmtr_alert_on_is_P_or_A,
    :rmtr_return_txt_is_mandatory_if_rmtr_alert_on_is_R_or_A,
    :nrtv_sufx_2_and_3_should_be_N_if_nrtv_sufx_1_is_N,
    :nrtv_sufx_3_should_be_N_if_nrtv_sufx_2_is_N,
    :customer_code_format, 
    :validate_account_token_length,
    :value_of_validation_fields
  end
  
  def val_tokens_should_be_N_if_val_method_is_N
    if (self.val_method == "N" && (self.val_token_1 != "N" || self.val_token_2 != "N" || self.val_token_3 != "N" || self.val_txn_date != "N" || self.val_txn_amt != "N")) 
      errors[:base] << "If Validation Method is None, then all the Validation Account Tokens should also be N"
    end
  end
  
  def file_upld_mthd_is_mandatory_if_val_method_is_D
    if (self.val_method == "D" && (self.file_upld_mthd.blank? || self.file_upld_mthd == 'N'))
      errors.add(:file_upld_mthd, "Can't be blank or None if Validation Method is Database Lookup")
    elsif (self.val_method != "D" && (self.file_upld_mthd != 'N' && !self.file_upld_mthd.blank?))
      errors.add(:file_upld_mthd, "Can't be selected as Validation Method is not Database Lookup")
    end
  end
  
  def same_value_cannot_be_selected_for_all_acct_tokens
    if (((self.token_1_type == self.token_2_type) && ((self.token_1_type != "N") && (self.token_2_type != "N"))) || 
      ((self.token_2_type == self.token_3_type) && ((self.token_2_type != "N") && (self.token_3_type != "N"))) || 
      ((self.token_1_type == self.token_3_type) && ((self.token_1_type != "N") && (self.token_3_type != "N"))))
      errors[:base] << "Can't allow same value for all tokens except for 'None'"
    end
  end
  
  def acct_token_2_and_3_should_be_N_if_acct_token_1_is_N
    if (self.token_1_type == "N" && (self.token_2_type != "N" || self.token_3_type != "N"))
      errors[:base] << "If Account Token 1 is None, then Account Token 2 & Account Token 3 should also be None"
    end
  end
  
  def acct_token_3_should_be_N_if_acct_toekn_2_is_N
    if (self.token_2_type == "N" && self.token_3_type != "N")
      errors[:base] << "If Account Token 2 is None, then Account Token 3 also should be None"
    end
  end
  
  def same_value_cannot_be_selected_for_all_nrtv_sufxs
    if (((self.nrtv_sufx_1 == self.nrtv_sufx_2) && ((self.nrtv_sufx_1 != "N") && (self.nrtv_sufx_2 != "N"))) || 
      ((self.nrtv_sufx_2 == self.nrtv_sufx_3) && ((self.nrtv_sufx_2 != "N") && (self.nrtv_sufx_3 != "N"))) || 
      ((self.nrtv_sufx_1 == self.nrtv_sufx_3) && ((self.nrtv_sufx_1 != "N") && (self.nrtv_sufx_3 != "N"))))
      errors[:base] << "Can't allow same value for all narration suffixes except for 'None'"
    end
  end
  
  def rmtr_pass_txt_is_mandatory_if_rmtr_alert_on_is_P_or_A
    if ((self.rmtr_alert_on == "P" || self.rmtr_alert_on == "A") && self.rmtr_pass_txt.blank?)
      errors.add(:rmtr_pass_txt, "Can't be blank if Send Alerts To Remitter On is On Pass or Always")
    end  
  end
  
  def rmtr_return_txt_is_mandatory_if_rmtr_alert_on_is_R_or_A 
    if ((self.rmtr_alert_on == "R" || self.rmtr_alert_on == "A") && self.rmtr_return_txt.blank?)
      errors.add(:rmtr_return_txt, "Can't be blank if Send Alerts To Remitter On is On Return or Always")
    end
  end
  
  def nrtv_sufx_2_and_3_should_be_N_if_nrtv_sufx_1_is_N
    if (self.nrtv_sufx_1 == "N" && (self.nrtv_sufx_2 != "N" || self.nrtv_sufx_3 != "N"))
      errors[:base] << "If Narrative Suffix 1 is None, then Narrative Suffix 2 & Narrative Suffix 3 should also be None"
    end
  end
  
  def nrtv_sufx_3_should_be_N_if_nrtv_sufx_2_is_N
    if (self.nrtv_sufx_2 == "N" && self.nrtv_sufx_3 != "N")
      errors[:base] << "If Narrative Suffix 2 is None, then Narrative Suffix 3 also should be None"
    end
  end
end