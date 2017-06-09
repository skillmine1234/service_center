class Fcr::Customer < ArFcr
  self.table_name = 'ci_custmast'
  self.primary_key = :cod_cust_id
  
  has_many :customer_accounts, foreign_key: :cod_cust
  has_many :allowed_corporate_accounts, -> { allowed_corporate_relationships }, foreign_key: :cod_cust, :class_name => 'Fcr::CustomerAccount'
  
  default_scope {where(flg_mnt_status: 'A')}
  
  def transfer_type_allowed?(transfer_type)
    if transfer_type == 'NEFT'
      (ref_phone_mobile.present? && ref_cust_email.present?) ? true : false
    end
  end
  
  def accounts
    allowed_corporate_accounts
  end

end