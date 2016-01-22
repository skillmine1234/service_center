require 'spec_helper'

describe ImtCustomersHelper do
  context "find_imt_customers" do
    it "should find imt_customers" do
      imt_customer = Factory(:imt_customer, :customer_code => '1234', :approval_status => "A")
      find_imt_customers({:customer_code => '1234'}).should == [imt_customer]
      find_imt_customers({:customer_code => '1111'}).should == []
      
      imt_customer = Factory(:imt_customer, :customer_name => 'ASDF', :approval_status => "A")
      find_imt_customers({:customer_name => 'ASDF'}).should == [imt_customer]
      find_imt_customers({:customer_name => 'OOOO'}).should == []
      
      imt_customer = Factory(:imt_customer, :account_no => '1234567890', :approval_status => "A")
      find_imt_customers({:account_no => '1234567890'}).should == [imt_customer]
      find_imt_customers({:account_no => '00000'}).should == []
    end
  end
  
  context "show_page_value_for_txn_mode" do
    it "should return show page value for txn_mode" do
      imt_customer = Factory(:imt_customer)
      show_page_value_for_txn_mode("F").should == "File"
      show_page_value_for_txn_mode("A").should == "Api"
    end
  end
end
