require 'spec_helper'

describe SmBankAccountsHelper do
  context "find_sm_bank_accounts" do
    it "should find sm_bank_accounts" do
      sm_bank_account1 = Factory(:sm_bank_account, :sm_code => 'AABB0CCC123', :approval_status => "A")
      find_sm_bank_accounts({:sm_code => 'AABB0CCC123'}).should == [sm_bank_account1]
      find_sm_bank_accounts({:sm_code => 'AABB0CCC124'}).should == []
      find_sm_bank_accounts({:sm_code => 'AABC0CCC123'}).should == []
      find_sm_bank_accounts({:sm_code => 'AABC 0CCC123'}).should == []
      find_sm_bank_accounts({:sm_code => 'AABC'}).should == []

      sm_bank_account2 = Factory(:sm_bank_account, :sm_code => "AABB0CCC124", :is_enabled => "Y", :approval_status => 'A')
      find_sm_bank_accounts({:is_enabled => "Y"}).should == [sm_bank_account1, sm_bank_account2]
      find_sm_bank_accounts({:is_enabled => "N"}).should == [] 

      sm_bank_account3 = Factory(:sm_bank_account, :customer_id => '9876', :approval_status => "A")
      find_sm_bank_accounts({:customer_id => '9876'}).should == [sm_bank_account3]
      find_sm_bank_accounts({:customer_id => '987'}).should == []
      find_sm_bank_accounts({:customer_id => '98765'}).should == []

      sm_bank_account4 = Factory(:sm_bank_account, :account_no => '155671235', :approval_status => "A")
      find_sm_bank_accounts({:account_no => '155671235'}).should == [sm_bank_account4]
      find_sm_bank_accounts({:account_no => '15567123'}).should == []
    end
  end  
end
