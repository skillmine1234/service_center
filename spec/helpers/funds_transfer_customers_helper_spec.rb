require 'spec_helper'

describe FundsTransferCustomersHelper do
  context "find_funds_transfer_customers" do
    it "should find funds_transfer_customers" do      
      funds_transfer_customer = Factory(:funds_transfer_customer, :tech_email_id => 'asd@fgh.com', :approval_status => "A")
      find_funds_transfer_customers({:tech_email_id => 'asd@fgh.com'}).should == [funds_transfer_customer]
      
      funds_transfer_customer = Factory(:funds_transfer_customer, :name => 'John', :approval_status => "A")
      find_funds_transfer_customers({:name => 'JOHN'}).should == [funds_transfer_customer]
      find_funds_transfer_customers({:name => 'OOOO'}).should == []
      
      funds_transfer_customer = Factory(:funds_transfer_customer, :name => 'SMITH', :approval_status => "A")
      find_funds_transfer_customers({:name => 'smith'}).should == [funds_transfer_customer]
      
      funds_transfer_customer = Factory(:funds_transfer_customer, :name => 'MaryJohn', :approval_status => "A")
      find_funds_transfer_customers({:name => 'mary'}).should == [funds_transfer_customer]
      
      funds_transfer_customer = Factory(:funds_transfer_customer, :name => 'Andrew', :approval_status => "A")
      find_funds_transfer_customers({:name => 'Andrew'}).should == [funds_transfer_customer]
      
      funds_transfer_customer = Factory(:funds_transfer_customer, :mobile_no => '9876543219', :approval_status => "A")
      find_funds_transfer_customers({:mobile_no => '9876543219'}).should == [funds_transfer_customer]
      
      funds_transfer_customer = Factory(:funds_transfer_customer, :account_no => '1934567890', :approval_status => "A")
      find_funds_transfer_customers({:account_no => '1934567890'}).should == [funds_transfer_customer]
      find_funds_transfer_customers({:account_no => '00000'}).should == []
    end
  end  
end
