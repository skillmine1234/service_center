require 'spec_helper'

describe SuCustomersHelper do
  context "find_su_customers" do
    it "should find su_customers" do
      su_customer = Factory(:su_customer, :account_no => '123456777', :approval_status => "A")
      find_su_customers({:account_no => '123456777'}).should == [su_customer]

      su_customer = Factory(:su_customer, :customer_id => '9008', :approval_status => "A")
      find_su_customers({:customer_id => '9008'}).should == [su_customer]
      find_su_customers({:customer_id => '9009'}).should == []

      su_customer = Factory(:su_customer, :pool_account_no => '1122334455', :approval_status => "A")
      find_su_customers({:pool_account_no => '1122334455'}).should == [su_customer]
      
      su_customer = Factory(:su_customer, :pool_customer_id => '111222333', :approval_status => "A")
      find_su_customers({:pool_customer_id => '111222333'}).should == [su_customer]
    end
  end  
end
