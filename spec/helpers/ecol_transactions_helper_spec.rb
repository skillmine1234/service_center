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

      ecol_transaction = Factory(:ecol_transaction, :status => 'SUCCESS', :notify_status => "PENDING NOTIFICATION", :transfer_unique_no => "oi wrw")
      find_ecol_transactions(val,{:notification_status => "PENDING NOTIFICATION"}).should == [ecol_transaction]
      find_ecol_transactions(val,{:notification_status => "FAILED"}).should_not == [ecol_transaction]
      
      ecol_transaction = Factory(:ecol_transaction, :status => 'SUCCESS', :settle_status => "PENDING SETTLEMENT", :transfer_unique_no => "oiopoi d")
      find_ecol_transactions(val,{:settle_status => "PENDING SETTLEMENT"}).should == [ecol_transaction]
      find_ecol_transactions(val,{:settle_status => "FAILED"}).should_not == [ecol_transaction]

      ecol_transaction = Factory(:ecol_transaction, :status => 'SUCCESS', :validation_status => "PENDING VALIDATION", :transfer_unique_no => "o iopoi")
      find_ecol_transactions(val,{:validation_status => "PENDING VALIDATION"}).should == [ecol_transaction]
      find_ecol_transactions(val,{:validation_status => "FAILED"}).should_not == [ecol_transaction]

      ecol_transaction = Factory(:ecol_transaction, :transfer_type => "ASD", :transfer_unique_no => "fvsdfaw")
      find_ecol_transactions(val,{:transfer_type => "ASD"}).should == [ecol_transaction]
      find_ecol_transactions(val,{:transfer_type => "AAA"}).should_not == [ecol_transaction] 

      ecol_transaction = Factory(:ecol_transaction, :transfer_type => "IMPS", :transfer_unique_no => "fvsdfax")
      find_ecol_transactions(val,{:transfer_type => "IMPS"}).should == [ecol_transaction]
      find_ecol_transactions(val,{:transfer_type => "NEFT"}).should_not == [ecol_transaction] 
      
      ecol_transaction = Factory(:ecol_transaction, :bene_account_no => "0987654321", :transfer_unique_no => "56789")
      find_ecol_transactions(val,{:bene_account_no => "0987654321"}).should == [ecol_transaction]
      find_ecol_transactions(val,{:bene_account_no => "1234567890"}).should_not == [ecol_transaction] 

      ecol_transaction = [Factory(:ecol_transaction, :transfer_timestamp => '2014-09-09', :transfer_unique_no => "xswert")]
      ecol_transaction << Factory(:ecol_transaction, :transfer_timestamp => '2014-10-09', :transfer_unique_no => "oyntrg")
      ecol_transaction << Factory(:ecol_transaction, :transfer_timestamp => '2014-11-09', :transfer_unique_no => "kucbfb")
      find_ecol_transactions(val,{:from_date => '2014-09-01', :to_date => '2014-12-01'}).should == ecol_transaction
      find_ecol_transactions(val,{:from_date => '2014-09-08', :to_date => '2014-09-12'}).should == [ecol_transaction[0]]
      
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
  
  context "show_page_value_for_validation_status" do
    it "should return show page value for valiadation status" do
      ecol_transaction = Factory(:ecol_transaction, :transfer_unique_no => "121212", :validation_status => "0")
      show_page_value_for_validation_status(ecol_transaction, "0").should == "SUCCESS"
      ecol_transaction = Factory(:ecol_transaction, :transfer_unique_no => "121213", :validation_status => "abcd")
      show_page_value_for_validation_status(ecol_transaction, "abcd").should == "abcd"
    end
  end

  context "pending_status" do
    it "should true if status is CREDIT FAILED, RETURN FAILED or VALIDATION FAILED" do
      pending_status('CREDIT FAILED').should == true
      pending_status('RETURN FAILED').should == true
      pending_status('VALIDATION FAILED').should == true
    end

    it "should false for other statuses" do
      pending_status('CREDIT').should == false
      pending_status('RETURN').should == false
    end
  end

  context "find_pending_status" do
    it "should return the first word" do
      find_pending_status('CREDIT FAILED').should == 'CREDIT'
      find_pending_status('RETURN FAILED').should == 'RETURN'
      find_pending_status('VALIDATION FAILED').should == 'VALIDATION'
    end
  end

  context "approval_status" do
    it "should true if status is PENDING CREDIT, PENDING RETURN" do
      approval_status('PENDING CREDIT').should == true
      approval_status('PENDING RETURN').should == true
    end

    it "should false for other statuses" do
      approval_status('CREDIT').should == false
      approval_status('RETURN').should == false
    end
  end

  context "find_approval_status" do
    it "should return the first word" do
      find_approval_status('PENDING CREDIT').should == 'CREDIT'
      find_approval_status('PENDING RETURN').should == 'RETURN'
    end
  end

  context "find_logs" do
    it "should return the logs" do
      transaction = Factory(:ecol_transaction)
      log = Factory(:ecol_audit_log, :ecol_transaction_id => transaction.id, :step_name => 'CREDIT')
      find_logs({:step_name => 'CREDIT'},transaction).should == transaction.ecol_audit_logs
      find_logs({:step_name => 'RETURN'},transaction).should == []
    end
  end

  context "check_transactions" do
    it "should return records and status" do
      transaction = Factory(:ecol_transaction, :status => 'PENDING CREDIT')
      check_transactions([transaction],{:status => 'PENDING CREDIT'}).should == {:records => [],:status => 'PENDING CREDIT'}
    end

    it "should return records and status" do
      transaction = Factory(:ecol_transaction, :status => 'PENDING RETURN')
      check_transactions([transaction],{:status => 'PENDING CREDIT'}).should == {:records => [transaction],:status => 'PENDING CREDIT'}
    end

    it "should return settlement records and status" do
      transaction = Factory(:ecol_transaction, :settle_status => 'SETTLEMENT FAILED')
      check_transactions([transaction],{:settle_status => 'SETTLEMENT FAILED'}).should == {:records => [],:status => 'SETTLEMENT FAILED'}
    end

    it "should return notification records and status" do
      transaction = Factory(:ecol_transaction, :notify_status => 'NOTIFICATION FAILED')
      check_transactions([transaction],{:notify_status => 'NOTIFICATION FAILED'}).should == {:records => [],:status => 'NOTIFICATION FAILED'}
    end
  end

  context "update_transactions" do
    it "should update approval records" do
      transaction = Factory(:ecol_transaction, :status => 'PENDING CREDIT', :pending_approval => 'Y')
      update_transactions([transaction],{:approval => 'Y', :status => 'PENDING CREDIT'})
      transaction.reload
      transaction.pending_approval.should == 'N'
    end

    it "should update status records" do
      transaction = Factory(:ecol_transaction, :status => 'CREDIT FAILED', :pending_approval => 'N')
      update_transactions([transaction],{:approval => 'N', :status => 'CREDIT FAILED'})
      transaction.reload
      transaction.status.should == 'PENDING CREDIT'
    end

    it "should update validation" do
      transaction = Factory(:ecol_transaction, :status => 'VALIDATION FAILED', :pending_approval => 'N')
      update_transactions([transaction],{:approval => 'N', :status => 'VALIDATION FAILED'})
      transaction.reload
      transaction.status.should == 'PENDING VALIDATION'
      transaction.validation_status.should == 'PENDING VALIDATION'
    end

    it "should update settlement records" do
      transaction = Factory(:ecol_transaction, :status => 'SETTLEMENT FAILED', :pending_approval => 'N')
      update_transactions([transaction],{:approval => 'N', :settle_status => 'SETTLEMENT FAILED'})
      transaction.reload
      transaction.settle_status.should == 'PENDING SETTLEMENT'
    end

    it "should update notification records" do
      transaction = Factory(:ecol_transaction, :status => 'NOTIFICATION FAILED', :pending_approval => 'N')
      update_transactions([transaction],{:approval => 'N', :notify_status => 'NOTIFICATION FAILED'})
      transaction.reload
      transaction.notify_status.should == 'PENDING NOTIFICATION'
    end
  end
end