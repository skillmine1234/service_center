class Atom::Customer < Atom
  self.table_name = 'mmid_master'
  self.primary_key = :customerid
  
  def self.imps_allowed_for_accounts?(accounts, fcr_mobile)
    accounts.each do |account|
      acct_no = account.cod_acct_no
      record = find_by_accountno(acct_no)
      return {account_no: acct_no, reason: "no record found in ATOM for #{acct_no}"} if record.nil?

      result = record.imps_allowed?(fcr_mobile)
      return {account_no: record.accountno, reason: "IMPS is not allowed for account_no #{record.accountno}"} if result == false
    end
    return true
  end

  def imps_allowed?(fcr_mobile_no)
    (mobileno == fcr_mobile_no && isactive == '1') ? true : false
  end

end