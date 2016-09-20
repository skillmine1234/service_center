require 'spec_helper'

describe PcIncomingRecordsHelper do
  context "find_pc_mm_cd_incoming_records" do
    it "should return records for the params that is passed" do 
      a = Factory(:pc_mm_cd_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :overrides => 'Y:76',:record_no => 23))
      find_pc_incoming_records({:overrided_flag => "true"},PcMmCdIncomingRecord.joins(:incoming_file_record)).should == [a]
      
      pc_mm_cd_incoming_record = Factory(:pc_mm_cd_incoming_record, :req_reference_no => '2222')
      find_pc_incoming_records({:req_no => '2222'},PcMmCdIncomingRecord.joins(:incoming_file_record)).should == [pc_mm_cd_incoming_record]
      find_pc_incoming_records({:req_no => '2223'},PcMmCdIncomingRecord.joins(:incoming_file_record)).should == []

      pc_mm_cd_incoming_record = Factory(:pc_mm_cd_incoming_record, :rep_reference_no=> '2222')
      find_pc_incoming_records({:rep_no => '2222'},PcMmCdIncomingRecord.joins(:incoming_file_record)).should == [pc_mm_cd_incoming_record]
      find_pc_incoming_records({:rep_no => '2223'},PcMmCdIncomingRecord.joins(:incoming_file_record)).should == []

      PcMmCdIncomingRecord.delete_all
      pc_mm_cd_incoming_record = Factory(:pc_mm_cd_incoming_record, :transfer_amount => 100)
      find_pc_incoming_records({:from_amount => 50},PcMmCdIncomingRecord.joins(:incoming_file_record)).should == [pc_mm_cd_incoming_record]
      find_pc_incoming_records({:to_amount => 150},PcMmCdIncomingRecord.joins(:incoming_file_record)).should == [pc_mm_cd_incoming_record]
    end
  end
end