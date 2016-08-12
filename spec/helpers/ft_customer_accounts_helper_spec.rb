require 'spec_helper'

describe FtCustomerAccountsHelper do
  context "find_ft_customer_accounts" do
    it "should find ft_customer_accounts" do      
      ft_customer_account = Factory(:ft_customer_account, :customer_id => Factory(:funds_transfer_customer, :customer_id => '12345', :enabled => 'Y', :approval_status => 'A').customer_id, :approval_status => "A")
      find_ft_customer_accounts({:customer_id => '12345'}).should == [ft_customer_account]
      find_ft_customer_accounts({:customer_id => '123456'}).should == []
    end
  end

  context "ft_customers_for_select" do
    it "should return all approved ft_customers records" do
      funds_transfer_customer1 = Factory(:funds_transfer_customer, :customer_id => "800001", :approval_status => 'A')
      funds_transfer_customer2 = Factory(:funds_transfer_customer, :customer_id => "800002", :approval_status => 'A')
      funds_transfer_customer3 = Factory(:funds_transfer_customer, :customer_id => "800003", :approval_status => 'A')
      funds_transfer_customer4 = Factory(:funds_transfer_customer, :customer_id => "800004")
      expect(ft_customers_for_select).to eq([["800001", "800001"], ["800002", "800002"], ["800003", "800003"]])
    end
  end
end
