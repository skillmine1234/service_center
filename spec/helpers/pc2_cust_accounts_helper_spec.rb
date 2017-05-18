require 'spec_helper'

describe Pc2CustAccountsHelper do
  include HelperMethods

  context "find_pc2_cust_accounts" do
    it "should find pc2_cust_accounts" do
      pc2_app = Factory(:pc2_app, :approval_status => 'A', :is_enabled => 'Y', :customer_id => '2111')
      pc2_cust_account = Factory(:pc2_cust_account, :customer_id => pc2_app.customer_id, :approval_status => 'A')
      find_pc2_cust_accounts({:customer_id => "2111"}).should == [pc2_cust_account]
      find_pc2_cust_accounts({:customer_id => "1100"}).should == []
    end
  end
end
