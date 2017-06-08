require 'spec_helper'

describe Fcr::Customer do
  
  context "transfer_type_allowed?" do
    it "should return true when neft is allowed for customer" do
      fcr_customer = Factory(:fcr_customer, cod_cust_id: '2345', ref_phone_mobile: '2222222222', ref_cust_email: 'aaa@gmail.com')
      fcr_customer.transfer_type_allowed?('NEFT').should == true
    end
    
    it "should return false when neft is not allowed for customer" do
      fcr_customer = Factory(:fcr_customer, cod_cust_id: '2345', ref_phone_mobile: '2222222222', ref_cust_email: nil)
      fcr_customer.transfer_type_allowed?('NEFT').should == false
    end
  end
  
  context "accounts" do
    it "should return all accounts for the customer" do
      fcr_customer = Factory(:fcr_customer, cod_cust_id: '2345', ref_phone_mobile: '2222222222', ref_cust_email: 'aaa@gmail.com')
      fcr_cust_acct1 = Factory(:fcr_cust_acct, cod_cust: '2345', cod_acct_cust_rel: 'GUR', cod_acct_no: '1234500000')
      fcr_cust_acct2 = Factory(:fcr_cust_acct, cod_cust: '2345', cod_acct_cust_rel: 'GUR', cod_acct_no: '1234511111')
      fcr_customer.accounts.should == [fcr_cust_acct1, fcr_cust_acct2]
    end
  end
end