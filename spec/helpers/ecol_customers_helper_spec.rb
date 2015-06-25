require 'spec_helper'

describe EcolCustomersHelper do
  
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
      
      ecol_customer = Factory(:ecol_customer, :code => "9543", :credit_acct_no => "9876543210", :approval_status => 'A')
      find_ecol_customers({:credit_acct_no => "9876543210"}).should == [ecol_customer]
      find_ecol_customers({:credit_acct_no => "0123456789"}).should_not == [ecol_customer]    
    end
  end
end
