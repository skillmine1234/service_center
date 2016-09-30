require 'spec_helper'

describe CnIncomingRecordsHelper do
  context "find_cn_incoming_records" do
    it "should return records for the params that is passed" do 
      a = Factory(:cn_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :overrides => 'Y:76',:record_no => 23))
      find_cn_incoming_records({:overrided_flag => "true"},CnIncomingRecord.joins(:incoming_file_record)).should == [a]
      
      cn_incoming_record = Factory(:cn_incoming_record, :transaction_ref_no=> '2222')
      find_cn_incoming_records({:ref_no => '2222'},CnIncomingRecord.joins(:incoming_file_record)).should == [cn_incoming_record]
      find_cn_incoming_records({:ref_no => '2223'},CnIncomingRecord.joins(:incoming_file_record)).should == []

      cn_incoming_record = Factory(:cn_incoming_record, :debit_account_no => '1234567')
      find_cn_incoming_records({:debit_account_no  => '1234567'},CnIncomingRecord.joins(:incoming_file_record)).should == [cn_incoming_record]
      find_cn_incoming_records({:debit_account_no  => '12345'},CnIncomingRecord.joins(:incoming_file_record)).should == []

      cn_incoming_record = Factory(:cn_incoming_record, :bene_account_no => '1234567')
      find_cn_incoming_records({:bene_account_no  => '1234567'},CnIncomingRecord.joins(:incoming_file_record)).should == [cn_incoming_record]
      find_cn_incoming_records({:bene_account_no  => '12345'},CnIncomingRecord.joins(:incoming_file_record)).should == []

      CnIncomingRecord.delete_all
      cn_incoming_record = Factory(:cn_incoming_record, :amount => 100)
      find_cn_incoming_records({:from_amount => 50},CnIncomingRecord.joins(:incoming_file_record)).should == [cn_incoming_record]
      find_cn_incoming_records({:to_amount => 150},CnIncomingRecord.joins(:incoming_file_record)).should == [cn_incoming_record]
    end
  end
end