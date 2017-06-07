require 'spec_helper'

describe Atom::Customer do

  context "get_customer_by_cust_id" do
    it "should return customer when searched on customer id" do
      atom_customer = Factory(:atom_customer, customerid: '2345', mobile: '2222222222', isactive: '1', accountno: '1234567890')
      Atom::Customer.get_customer_by_cust_id('2345').should == atom_customer

      Atom::Customer.get_customer_by_cust_id('1111').should == nil
    end
  end
  
  context "get_customer_by_debit_acct" do
    it "should return customer when searched on customer id" do
      atom_customer = Factory(:atom_customer, customerid: '2345', mobile: '2222222222', isactive: '1', accountno: '1234567890')
      Atom::Customer.get_customer_by_debit_acct('1234567890').should == atom_customer

      Atom::Customer.get_customer_by_debit_acct('1111111111').should == nil
    end
  end

  context "imps_allowed?" do
    it "should return true when imps is allowed for customer" do
      atom_customer = Factory(:atom_customer, customerid: '2345', mobile: '2222222222', isactive: '1')
      atom_customer.imps_allowed?.should == true
    end

    it "should return false when imps is not allowed for customer" do
      atom_customer = Factory(:atom_customer, customerid: '2345', mobile: '9999999999', isactive: '1')
      atom_customer.imps_allowed?.should == false
    end
  end
end