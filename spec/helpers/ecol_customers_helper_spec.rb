require 'spec_helper'

describe EcolCustomersHelper do
  include HelperMethods
  
  before(:each) do
    mock_ldap
  end
  
  context "show_page_value_for_account_tokens" do
    it "should show token description" do
      ecol_customer = Factory.build(:ecol_customer, :token_1_type => "N", :token_2_type => "RC", :token_3_type => "SC")
      show_page_value_for_account_tokens("N").should == "None"
      ecol_customer = Factory.build(:ecol_customer, :token_2_type => "RC")
      show_page_value_for_account_tokens("RC").should == "Remitter Code"
      ecol_customer = Factory.build(:ecol_customer, :token_3_type => "SC")
      show_page_value_for_account_tokens("SC").should == "Sub Code"
    end
  end
  
  context "show_page_value_for_val_method" do
    it "should show method description" do
      ecol_customer = Factory.build(:ecol_customer, :val_method => "N")
      show_page_value_for_val_method("N").should == "None"
      ecol_customer = Factory.build(:ecol_customer, :val_method => "W")
      show_page_value_for_val_method("W").should == "Web Service"
      ecol_customer = Factory.build(:ecol_customer, :val_method => "D")
      show_page_value_for_val_method("D").should == "Database Lookup"
    end
  end
  
  context "find_ecol_customers" do 
    it "should return ecol customers" do
      ecol_customer = Factory(:ecol_customer, :code => "9876", :approval_status => 'A')
      find_ecol_customers({:code => "9876"}).should == [ecol_customer]
      find_ecol_customers({:code => "9000"}).should_not == [ecol_customer]    
      
      ecol_customer = Factory(:ecol_customer, :code => "9654", :is_enabled => "N", :approval_status => 'A')
      find_ecol_customers({:is_enabled => "N"}).should == [ecol_customer]
      find_ecol_customers({:is_enabled => "Y"}).should_not == [ecol_customer] 

      ecol_customer = Factory(:ecol_customer, :code => "9876", :approval_status => 'U')  
      find_ecol_customers({:approval_status => "U"}).should == [ecol_customer]
      find_ecol_customers({}).should_not == [ecol_customer]
      
      ecol_customer = Factory(:ecol_customer, :code => "9888", :approval_status => 'A', :credit_acct_val_pass => '7634456786')
      find_ecol_customers({:credit_acct_val_pass => '7634456786'}).should == [ecol_customer]
      find_ecol_customers({:credit_acct_val_pass => '0987654321'}).should_not == [ecol_customer] 
    
      ecol_customer = Factory(:ecol_customer, :code => "9777", :approval_status => 'A', :credit_acct_val_fail => '7634456786')
      find_ecol_customers({:credit_acct_val_fail => '7634456786'}).should == [ecol_customer]
      find_ecol_customers({:credit_acct_val_fail => '8756456789'}).should_not == [ecol_customer] 
    end
  end
  
  context "show_page_value_for_nrtv_sufx" do
    it "should show description for nrtv_sufx" do
      show_page_value_for_nrtv_sufx("N").should == "None"
      show_page_value_for_nrtv_sufx("SC").should == "Sub Code"
      show_page_value_for_nrtv_sufx("RC").should == "Remitter Code"
      show_page_value_for_nrtv_sufx("RN").should == "Remitter Name"
      show_page_value_for_nrtv_sufx("IN").should =="Invoice Number"
      show_page_value_for_nrtv_sufx("ORN").should == "Original Remitter Name"
      show_page_value_for_nrtv_sufx("ORA").should == "Original Remitter Account"
      show_page_value_for_nrtv_sufx("TUN").should == "Transfer Unique No"
      show_page_value_for_nrtv_sufx("UDF1").should == "User Defined Field 1"
      show_page_value_for_nrtv_sufx("UDF2").should == "User Defined Field 2"
    end
  end
  
  context "get_allowed_operations" do
    it "should return the value of allowed_operations as string" do
      ecol_customer = Factory(:ecol_customer, allowed_operations: ['getStatus', 'returnPayment'], return_if_val_reject: 'Y')
      get_allowed_operations(ecol_customer.allowed_operations).should == 'getStatus, returnPayment'
    end
  end
end
