require 'spec_helper'

describe IcIncomingRecordsHelper do
  context "find_ic_incoming_records" do
    it "should return records for the params that is passed" do 
      a = Factory(:ic_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :should_skip => 'Y'))
      find_ic_incoming_records({:skipped_flag => "Y"},IcIncomingRecord.joins(:incoming_file_record)).should == [a]
      find_ic_incoming_records({:skipped_flag => "N"},IcIncomingRecord.joins(:incoming_file_record)).should == []
      a = Factory(:ic_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :overrides => 'Y:76',:record_no => 23))
      find_ic_incoming_records({:overrided_flag => "true"},IcIncomingRecord.joins(:incoming_file_record)).should == [a]
      
      ic_incoming_record = Factory(:ic_incoming_record, :supplier_code => '2222')
      find_ic_incoming_records({:supplier_code => '2222'},IcIncomingRecord.joins(:incoming_file_record)).should == [ic_incoming_record]
      find_ic_incoming_records({:supplier_code => '2223'},IcIncomingRecord.joins(:incoming_file_record)).should == []

      ic_incoming_record = Factory(:ic_incoming_record, :invoice_no=> '2222')
      find_ic_incoming_records({:invoice_no => '2222'},IcIncomingRecord.joins(:incoming_file_record)).should == [ic_incoming_record]
      find_ic_incoming_records({:invoice_no => '2223'},IcIncomingRecord.joins(:incoming_file_record)).should == []

      ic_incoming_record = Factory(:ic_incoming_record, :debit_ref_no => '2222')
      find_ic_incoming_records({:debit_ref_no => '2222'},IcIncomingRecord.joins(:incoming_file_record)).should == [ic_incoming_record]
      find_ic_incoming_records({:debit_ref_no => '2223'},IcIncomingRecord.joins(:incoming_file_record)).should == []

      ic_incoming_record = Factory(:ic_incoming_record, :invoice_amount => 100)
      find_ic_incoming_records({:from_amount => 50, :to_amount => 200},IcIncomingRecord.joins(:incoming_file_record)).should == [ic_incoming_record]
      find_ic_incoming_records({:from_amount => 150, :to_amount => 200},IcIncomingRecord.joins(:incoming_file_record)).should == []

      ic_incoming_record = Factory(:ic_incoming_record, :invoice_date => Date.new(2016,3,15))
      find_ic_incoming_records({:from_date => "14-3-2016", :to_date => "16-3-2016"},IcIncomingRecord.joins(:incoming_file_record)).should == [ic_incoming_record]
      find_ic_incoming_records({:from_date => "13-3-2016", :to_date => "14-3-2016"},IcIncomingRecord.joins(:incoming_file_record)).should == []    
    end
  end
end