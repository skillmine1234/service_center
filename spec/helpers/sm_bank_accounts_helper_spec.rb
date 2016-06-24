require 'spec_helper'

describe SmBankAccountsHelper do
  context "find_sm_bank_accounts" do
    it "should find sm_bank_accounts" do
      sm_bank_account = Factory(:sm_bank_account, :sm_code => 'SM1111', :approval_status => "A")
      find_sm_bank_accounts({:sm_code => 'SM1111'}).should == [sm_bank_account]
      find_sm_bank_accounts({:sm_code => 'sm1111'}).should == [sm_bank_account]
      find_sm_bank_accounts({:sm_code => 'Sm1111'}).should == [sm_bank_account]
      find_sm_bank_accounts({:sm_code => 'SM111'}).should == []
      find_sm_bank_accounts({:sm_code => 'sm11111'}).should == []

      sm_bank_account = Factory(:sm_bank_account, :customer_id => '9876', :approval_status => "A")
      find_sm_bank_accounts({:customer_id => '9876'}).should == [sm_bank_account]
      find_sm_bank_accounts({:customer_id => '987'}).should == []
      find_sm_bank_accounts({:customer_id => '98765'}).should == []

      sm_bank_account = Factory(:sm_bank_account, :account_no => 'ACC010', :approval_status => "A")
      find_sm_bank_accounts({:account_no => 'ACC010'}).should == [sm_bank_account]
      find_sm_bank_accounts({:account_no => 'acc010'}).should == [sm_bank_account]
      find_sm_bank_accounts({:account_no => 'acc01'}).should == []
      find_sm_bank_accounts({:account_no => 'acc0100'}).should == []
    end
  end  
end
