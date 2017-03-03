require 'spec_helper'

describe Cnb2IncomingRecordsHelper do
  context "find_cnb2_incoming_records" do
    it "should return records for the params that is passed" do 
      a = Factory(:cnb2_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :overrides => 'Y:76',:record_no => 23))
      find_cnb2_incoming_records({:overrided_flag => "true"},Cnb2IncomingRecord.joins(:incoming_file_record)).should == [a]
      
      cnb2_incoming_record = Factory(:cnb2_incoming_record, :vendor_code=> '2222')
      find_cnb2_incoming_records({:vendor_code => '2222'},Cnb2IncomingRecord.joins(:incoming_file_record)).should == [cnb2_incoming_record]
      find_cnb2_incoming_records({:vendor_code => '2223'},Cnb2IncomingRecord.joins(:incoming_file_record)).should == []

      cnb2_incoming_record = Factory(:cnb2_incoming_record, :bene_account_no => '1234567')
      find_cnb2_incoming_records({:bene_account_no  => '1234567'},Cnb2IncomingRecord.joins(:incoming_file_record)).should == [cnb2_incoming_record]
      find_cnb2_incoming_records({:bene_account_no  => '12345'},Cnb2IncomingRecord.joins(:incoming_file_record)).should == []

      # Cnb2IncomingRecord.delete_all
      # cnb2_incoming_record = Factory(:cnb2_incoming_record, :amount => 100)
      # find_cnb2_incoming_records({:from_amount => 50},Cnb2IncomingRecord.joins(:incoming_file_record)).should == [cnb2_incoming_record]
      # find_cnb2_incoming_records({:to_amount => 150},Cnb2IncomingRecord.joins(:incoming_file_record)).should == [cnb2_incoming_record]
    end
  end
end