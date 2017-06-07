require 'spec_helper'

describe Fcr::Customer do

  context "get_customer" do
    it "should return customer" do
      fcr_customer = Factory(:fcr_customer, cod_cust_id: '2345', ref_phone_mobile: '2222222222', ref_cust_email: 'aaa@gmail.com')
      Fcr::Customer.get_customer('2345').should == fcr_customer
      
      Fcr::Customer.get_customer('1111').should == nil
    end
  end
  
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
end