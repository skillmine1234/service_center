require 'spec_helper'

describe BmBillPaymentHelper do
  
  context 'find_bm_bill_payment' do
    it 'should return inward remittances' do
      bm_bill_payments = Factory(:bm_bill_payment,:status => 'NEW')
      val = BmBillPayment
      find_bm_bill_payments(val,{:status => 'NEW'}).should == [bm_bill_payments]
      find_bm_bill_payments(val,{:status => 'COMPLETED'}).should == []
      
      bm_bill_payment = Factory(:bm_bill_payment,:req_no => 'R1234')
      find_bm_bill_payments(val,{:request_no => 'R1234'}).should == [bm_bill_payment]
      find_bm_bill_payments(val,{:request_no => 'r1234'}).should == [bm_bill_payment]
      find_bm_bill_payments(val,{:request_no => 'r12'}).should == [bm_bill_payment]
      find_bm_bill_payments(val,{:request_no => 'R12'}).should == [bm_bill_payment]
      find_bm_bill_payments(val,{:request_no => '4321R'}).should == []
  
      bm_bill_payment = Factory(:bm_bill_payment,:customer_id => '12345')
      find_bm_bill_payments(val,{:cust_id => '12345'}).should == [bm_bill_payment]
      find_bm_bill_payments(val,{:cust_id => '123455'}).should == []

      bm_bill_payment = Factory(:bm_bill_payment,:debit_account_no => '98762')
      find_bm_bill_payments(val,{:debit_no => '98762'}).should == [bm_bill_payment]
      find_bm_bill_payments(val,{:debit_no => '123455'}).should == []

      bm_bill_payment = Factory(:bm_bill_payment,:txn_kind => 'Debit')
      find_bm_bill_payments(val,{:txn_kind => 'Debit'}).should == [bm_bill_payment]
      find_bm_bill_payments(val,{:txn_kind => 'Credit'}).should == []

      bm_bill_payment1 = Factory(:bm_bill_payment, :txn_amount => '10000')
      bm_bill_payment2 = Factory(:bm_bill_payment, :txn_amount => '9000')
      bm_bill_payment3 = Factory(:bm_bill_payment, :txn_amount => '8000')
      find_bm_bill_payments(val,{:from_amount => '8000', :to_amount => '10000'}).should == [bm_bill_payment1,bm_bill_payment2,bm_bill_payment3]
      find_bm_bill_payments(val,{:from_amount => '10000', :to_amount => '12000'}).should == [bm_bill_payment1]

      bm_bill_payment = Factory(:bm_bill_payment,:biller_code => 'AV123')
      find_bm_bill_payments(val,{:biller_code => 'AV123'}).should == [bm_bill_payment]
      find_bm_bill_payments(val,{:biller_code => 'Be2312'}).should == []

      bm_bill_payment = Factory(:bm_bill_payment,:biller_acct_no => 'AV123')
      find_bm_bill_payments(val,{:biller_acct_no => 'AV123'}).should == [bm_bill_payment]
      find_bm_bill_payments(val,{:biller_acct_no => 'Be2312'}).should == []

      bm_bill_payment = Factory(:bm_bill_payment,:bill_id => 'AV123')
      find_bm_bill_payments(val,{:bill_id => 'AV123'}).should == [bm_bill_payment]
      find_bm_bill_payments(val,{:bill_id => 'Be2312'}).should == []   
    end
  end
end