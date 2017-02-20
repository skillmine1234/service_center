require 'spec_helper'

describe RrIncomingRecordsHelper do
  context "find_rr_incoming_records" do
    it "should return records for the params that is passed" do 
      a = Factory(:rr_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :overrides => 'Y:76',:record_no => 23))
      find_rr_incoming_records({:overrided_flag => "true"},RrIncomingRecord.joins(:incoming_file_record)).should == [a]
      
      rr_incoming_record = Factory(:rr_incoming_record, :bank_ref_no=> '2222')
      find_rr_incoming_records({:bank_ref_no => '2222'},RrIncomingRecord.joins(:incoming_file_record)).should == [rr_incoming_record]
      find_rr_incoming_records({:bank_ref_no => '2223'},RrIncomingRecord.joins(:incoming_file_record)).should == []

      rr_incoming_record = Factory(:rr_incoming_record, :txn_type => 'RTGS')
      find_rr_incoming_records({:txn_type  => 'RTGS'},RrIncomingRecord.joins(:incoming_file_record)).should == [rr_incoming_record]
      find_rr_incoming_records({:txn_type  => 'NEFT'},RrIncomingRecord.joins(:incoming_file_record)).should == []
    end
  end
end