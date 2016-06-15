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

  context "can_select" do 
    it "should return true if the fault_code present" do 
      a = Factory(:su_incoming_record, :incoming_file_record_id => Factory(:incoming_file_record, :fault_code => "ns:W").id)
      can_select?(a).should == true
    end

    it "should return false if the fault_code is null" do 
      a = Factory(:su_incoming_record, :incoming_file_record_id => Factory(:incoming_file_record, :fault_code => nil).id)
      can_select?(a).should == false
    end
  end
end