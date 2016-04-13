require 'spec_helper'

describe SuIncomingRecordsHelper do
  context "find_logs" do 
    it "should return audit_steps results" do 
      incoming_record = Factory(:incoming_file_record)
      a = Factory(:fm_audit_step, :auditable_id => incoming_record.id, :auditable_type => "IncomingFileRecord")
      params = {:id => incoming_record.id, :step_name => "ALL"}
      find_logs(params,incoming_record).should == [a]
    end
  end

  context "find_su_incoming_records" do
    it "should return records for the params that is passed" do 
      a = Factory(:su_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :should_skip => 'Y'))
      find_su_incoming_records({:skipped_flag => "Y"},SuIncomingRecord.joins(:incoming_file_record)).should == [a]
      find_su_incoming_records({:skipped_flag => "N"},SuIncomingRecord.joins(:incoming_file_record)).should == []
      a = Factory(:su_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :overrides => 'Y:76',:record_no => 23))
      find_su_incoming_records({:overrided_flag => "true"},SuIncomingRecord.joins(:incoming_file_record)).should == [a]
      a = Factory(:su_incoming_record, :corp_account_no => "1234")
      find_su_incoming_records({:corp_account_no => "1234"},SuIncomingRecord).should == [a]
      find_su_incoming_records({:corp_account_no => "4321"},SuIncomingRecord).should == []
      a = Factory(:su_incoming_record, :emp_account_no => "1234")
      find_su_incoming_records({:emp_account_no => "1234"},SuIncomingRecord).should == [a]
      find_su_incoming_records({:emp_account_no => "4321"},SuIncomingRecord).should == []
      a = Factory(:su_incoming_record, :emp_name => "FoorBar")
      find_su_incoming_records({:emp_name => "FoorBar"},SuIncomingRecord).should == [a]
      find_su_incoming_records({:emp_name => "Foo"},SuIncomingRecord).should == []
      a = Factory(:su_incoming_record, :salary_amount => 10000)
      find_su_incoming_records({:from_amount => 5000, :to_amount => 15000},SuIncomingRecord).should == [a]
      find_su_incoming_records({:from_amount => 500, :to_amount => 1000},SuIncomingRecord).should == []
    end
  end

  context "check_records" do
    it "should return the records that satisfy the conditions" do
      record = Factory(:su_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :status => "FAILED", :should_skip => 'Y', :overrides => nil))
      check_records([record],{:status => 'override'}).should == [record]
    end
  end

  context "override_records" do
    it "should return the records that satisfy the conditions" do
      record = Factory(:su_incoming_record, :incoming_file_record => Factory(:incoming_file_record, :status => "FAILED", :should_skip => 'N', :overrides => nil, :fault_code => 'ns:W123'))
      override_records([record],{:status => 'override'})
      record.incoming_file_record.reload
      record.incoming_file_record.overrides.should == 'ns:W123'
    end
  end
end