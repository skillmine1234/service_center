class Fcr::Customer < ArFcr
  self.table_name = 'ci_custmast'
  self.primary_key = :cod_cust_id
  
  alias_attribute :ref_phone_mobile, :ref_cust_telex

  def transfer_type_allowed?(transfer_type)
    if transfer_type == 'NEFT'
      (ref_phone_mobile.present? && ref_cust_email.present?) ? true : false
    end
  end
  
  def self.get_customer(cust_id)
    find_by(cod_cust_id: cust_id)
  end
end