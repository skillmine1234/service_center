require 'spec_helper'

describe EcolTransactionsHelper do
  context "find_ecol_transactions" do
    it "should return ecol trasactions" do
      ecol_transaction = Factory(:ecol_transaction, :transfer_unique_no => "12345")
      val = EcolTransaction
      find_ecol_transactions(val,{:transfer_unique_no => "12345"}).should == [ecol_transaction]
      find_ecol_transactions(val,{:transfer_unique_no => " 12345"}).should == [ecol_transaction]
      find_ecol_transactions(val,{:transfer_unique_no => "98761"}).should_not == [ecol_transaction]

      ecol_transaction = Factory(:ecol_transaction, :transfer_unique_no => " 53523")
      find_ecol_transactions(val,{:transfer_unique_no => "53523"}).should == [ecol_transaction] 
      
      ecol_transaction = Factory(:ecol_transaction, :customer_code => "123456")
      find_ecol_transactions(val,{:customer_code => "123456"}).should == [ecol_transaction]
      find_ecol_transactions(val,{:customer_code => "9876112"}).should_not == [ecol_transaction]
      
      ecol_transaction = Factory(:ecol_transaction, :status => "NEW", :transfer_unique_no => "ojkpoi", :pending_approval => "Y")
      find_ecol_transactions(val,{:status => "NEW",:pending_approval => "Y"}).should == [ecol_transaction]
      find_ecol_transactions(val,{:status => "FAILED",:pending_approval => "Y"}).should_not == [ecol_transaction]
      
      ecol_transaction = Factory(:ecol_transaction, :status => "SUCCESS", :transfer_unique_no => "oiopoi")
      find_ecol_transactions(val,{:status => "SUCCESS"}).should == [ecol_transaction]
      find_ecol_transactions(val,{:status => "FAILED"}).should_not == [ecol_transaction]
      
      ecol_transaction = Factory(:ecol_transaction, :transfer_type => "ASD", :transfer_unique_no => "fvsdfaw")
      find_ecol_transactions(val,{:transfer_type => "ASD"}).should == [ecol_transaction]
      find_ecol_transactions(val,{:transfer_type => "AAA"}).should_not == [ecol_transaction] 
      
      ecol_transaction = Factory(:ecol_transaction, :bene_account_no => "0987654321", :transfer_unique_no => "56789")
      find_ecol_transactions(val,{:bene_account_no => "0987654321"}).should == [ecol_transaction]
      find_ecol_transactions(val,{:bene_account_no => "1234567890"}).should_not == [ecol_transaction] 

      ecol_transaction = [Factory(:ecol_transaction, :transfer_date => '2014-09-09', :transfer_unique_no => "xswert")]
      ecol_transaction << Factory(:ecol_transaction, :transfer_date => '2014-10-09', :transfer_unique_no => "oyntrg")
      ecol_transaction << Factory(:ecol_transaction, :transfer_date => '2014-11-09', :transfer_unique_no => "kucbfb")
      find_ecol_transactions(val,{:from_transfer_date => '2014-09-01', :to_transfer_date => '2014-12-01'}).should == ecol_transaction
      find_ecol_transactions(val,{:from_transfer_date => '2014-09-09', :to_transfer_date => '2014-09-12'}).should == [ecol_transaction[0]]
      
      ecol_transaction = [Factory(:ecol_transaction, :transfer_amt => '10000', :transfer_unique_no => "76543")]
      ecol_transaction << Factory(:ecol_transaction, :transfer_amt => '9000', :transfer_unique_no => "98657")
      ecol_transaction << Factory(:ecol_transaction, :transfer_amt => '8000', :transfer_unique_no => "56578")
      find_ecol_transactions(val,{:from_amount => '8000', :to_amount => '10000'}).should == ecol_transaction
      find_ecol_transactions(val,{:from_amount => '10000', :to_amount => '12000'}).should == [ecol_transaction[0]]
    end  
  end
  
  context "ecol_transaction_token_show" do
    it "should return token types from customer" do
      ecol_customer = Factory(:ecol_customer, :code => '9876', :token_1_type => 'SC', :token_1_length => 1, :approval_status => 'A')
      ecol_transaction = Factory(:ecol_transaction, :customer_code => '9876', :transfer_type => "ASD", :transfer_unique_no => "oiopoi")
      ecol_transaction_token_show(ecol_transaction,0).should == ecol_transaction.customer_subcode
      ecol_customer = Factory(:ecol_customer, :code => '9111', :token_1_type => 'RC', :token_1_length => 1, :approval_status => 'A')
      ecol_transaction_token_show(ecol_transaction,1).should == ecol_transaction.remitter_code
      ecol_customer = Factory(:ecol_customer, :code => '9000', :token_1_type => 'IN', :token_1_length => 1, :approval_status => 'A')
      ecol_transaction_token_show(ecol_transaction,2).should == ecol_transaction.invoice_no
      ecol_customer = Factory(:ecol_customer, :code => '9222', :token_1_type => 'N', :token_1_length => 0, :approval_status => 'A')
      ecol_transaction_token_show(ecol_transaction,1).should == nil
      ecol_transaction = Factory(:ecol_transaction, :customer_code => '9999', :transfer_type => "QWE", :transfer_unique_no => "lklklk")
      ecol_transaction_token_show(ecol_transaction,1).should == '-'
    end
  end
  
  context "txn_summary_count" do
    it "should return correct count" do
      txn_summary_count({["NEW","N"] => 1, ["NEW","Y"] => 1, ["SUCCESS","N"] => 1},['NEW','Y']).should == 1
      txn_summary_count({["FAILED","N"] => 1, ["SUCCESS","Y"] => 1, ["SUCCESS","N"] => 1},['SUCCESS','Y']).should == 1
      txn_summary_count({["FAILED","N"] => 1, ["SUCCESS","Y"] => 1, ["SUCCESS","N"] => 1},['FAILED','Y']).should == 0
    end
  end
end
