require 'spec_helper'

describe IcCustomersHelper do
  context "find_ic_customers" do
    it "should find ic_customers" do
      ic_customer = Factory(:ic_customer, :customer_id => "1122", :approval_status => "A")
      find_ic_customers({:customer_id => '1122'}).should == [ic_customer]
      find_ic_customers({:customer_id => '1123'}).should == []
      
      ic_customer = Factory(:ic_customer, :app_id => '88888', :approval_status => "A")
      find_ic_customers({:app_id => '88888'}).should == [ic_customer]
      find_ic_customers({:app_id => '88887'}).should == []

      ic_customer = Factory(:ic_customer, :identity_user_id => '7777', :approval_status => "A")
      find_ic_customers({:identity_user_id => '7777'}).should == [ic_customer]
      find_ic_customers({:identity_user_id => '7776'}).should == []
      
      ic_customer = Factory(:ic_customer, :repay_account_no => '6666666666', :approval_status => "A")
      find_ic_customers({:repay_account_no => '6666666666'}).should == [ic_customer]
      find_ic_customers({:repay_account_no => '6666666665'}).should == []

      ic_customer = Factory(:ic_customer, :fee_pct => '8.88', :approval_status => "A")
      find_ic_customers({:fee_pct => '8.88'}).should == [ic_customer]
      find_ic_customers({:fee_pct => '8.98'}).should == []

      ic_customer = Factory(:ic_customer, :fee_income_gl => '123456', :approval_status => "A")
      find_ic_customers({:fee_income_gl => '123456'}).should == [ic_customer]
      find_ic_customers({:fee_income_gl => '12345'}).should == []
    end
  end  
end
