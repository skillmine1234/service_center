require 'spec_helper'

describe FundsTransferCustomersHelper do
  include HelperMethods

  before(:each) do
    mock_ldap
  end

  context "find_funds_transfer_customers" do
    it "should find funds_transfer_customers" do      
      funds_transfer_customer = Factory(:funds_transfer_customer, :app_id => 'a12345', :approval_status => "A")
      find_funds_transfer_customers({:app_id => 'a12345'}).should == [funds_transfer_customer]
      
      funds_transfer_customer = Factory(:funds_transfer_customer, :name => 'John', :approval_status => "A")
      find_funds_transfer_customers({:name => 'JOHN'}).should == [funds_transfer_customer]
      find_funds_transfer_customers({:name => 'OOOO'}).should == []
    end
  end

  context "get_allowed_relns" do
    it "should return allowed relations for a customer" do
      funds_transfer_customer = Factory(:funds_transfer_customer, approval_status: "A", is_retail: 'Y', allowed_relns: nil)
      get_allowed_relns(funds_transfer_customer).should ==  "GUR, JOF, JOO, SOW, TRU"
      
      funds_transfer_customer = Factory(:funds_transfer_customer, approval_status: "A", is_retail: 'N', allowed_relns: nil)
      get_allowed_relns(funds_transfer_customer).should ==  "GUR, JOF, JOO, SOW, TRU, AUS"
      
      funds_transfer_customer = Factory(:funds_transfer_customer, approval_status: "A", use_std_relns: 'N', allowed_relns: ['GUR','JOF','AUS'])
      get_allowed_relns(funds_transfer_customer).should ==  "GUR, JOF, AUS"
    end
  end
end
