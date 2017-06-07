class Atom::Customer < Atom
  self.table_name = 'mmid_master'
  self.primary_key = :customerid
  
  alias_attribute :mobile, :mobileno

  def imps_allowed?
    (mobile == '2222222222' && isactive == '1') ? true : false
  end
  
  def self.get_customer_by_cust_id(cust_id)
    find_by(customerid: cust_id)
  end
  
  def self.get_customer_by_debit_acct(acct_no)
    find_by(accountno: acct_no)
  end
end