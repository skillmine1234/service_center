require 'spec_helper'

describe Atom::Customer do

  context "imps_allowed?" do
    it "should return true when imps is allowed for customer" do
      atom_customer = Factory(:atom_customer, customerid: '2345', mobileno: '2222222222', isactive: '1')
      atom_customer.imps_allowed?('2222222222').should == true
    end

    it "should return false when imps is not allowed for customer" do
      atom_customer = Factory(:atom_customer, customerid: '2345', mobileno: '9999999999', isactive: '1')
      atom_customer.imps_allowed?('2222222222').should == false
    end
  end
  
  context "imps_allowed_for_accounts" do
    it "should return true if imps is allowed for all accounts" do
      fcr_customer = Factory(:fcr_customer, cod_cust_id: '2345', ref_phone_mobile: '2222222222', ref_cust_email: 'aaa@gmail.com')
      fcr_cust_acct1 = Factory(:fcr_cust_acct, cod_cust: '2345', cod_acct_cust_rel: 'GUR', cod_acct_no: '1234511111')
      fcr_cust_acct2 = Factory(:fcr_cust_acct, cod_cust: '2345', cod_acct_cust_rel: 'GUR', cod_acct_no: '1234522222')
      atom_customer1 = Factory(:atom_customer, customerid: '2345', mobileno: '2222222222', isactive: '1', accountno: '1234511111')
      atom_customer2 = Factory(:atom_customer, customerid: '2345', mobileno: '2222222222', isactive: '1', accountno: '1234522222')
      Atom::Customer.imps_allowed_for_accounts?([fcr_cust_acct1,fcr_cust_acct2], '2222222222').should == true
    end

    it "should return error hash if record is not present in ATOM for all accounts" do
      fcr_customer = Factory(:fcr_customer, cod_cust_id: '2345', ref_phone_mobile: '2222222222', ref_cust_email: 'aaa@gmail.com')
      fcr_cust_acct1 = Factory(:fcr_cust_acct, cod_cust: '2345', cod_acct_cust_rel: 'GUR', cod_acct_no: '1234511111')
      fcr_cust_acct2 = Factory(:fcr_cust_acct, cod_cust: '2345', cod_acct_cust_rel: 'GUR', cod_acct_no: '1234522222')
      atom_customer1 = Factory(:atom_customer, customerid: '2345', mobileno: '2222222222', isactive: '1', accountno: '1234511111')
      Atom::Customer.imps_allowed_for_accounts?([fcr_cust_acct1,fcr_cust_acct2], '2222222222').should == {account_no: '1234522222', reason: 'no record found in ATOM for 1234522222'}
    end
    
    it "should return error hash if imps is not allowed for all accounts" do
      fcr_customer = Factory(:fcr_customer, cod_cust_id: '2345', ref_phone_mobile: '2222222222', ref_cust_email: 'aaa@gmail.com')
      fcr_cust_acct1 = Factory(:fcr_cust_acct, cod_cust: '2345', cod_acct_cust_rel: 'GUR', cod_acct_no: '1234511111')
      fcr_cust_acct2 = Factory(:fcr_cust_acct, cod_cust: '2345', cod_acct_cust_rel: 'GUR', cod_acct_no: '1234522222')
      atom_customer1 = Factory(:atom_customer, customerid: '2345', mobileno: '2222222222', isactive: '1', accountno: '1234511111')
      atom_customer2 = Factory(:atom_customer, customerid: '2345', mobileno: '9999990000', isactive: '1', accountno: '1234522222')
      Atom::Customer.imps_allowed_for_accounts?([fcr_cust_acct1,fcr_cust_acct2], '2222222222').should == {account_no: '1234522222', reason: 'IMPS is not allowed for account_no 1234522222'}
    end
  end
end