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
end
