require 'spec_helper'

describe RcTransferSchedulesHelper do
  context "find_rc_transfer_schedules" do
    it "should find rc_transfer_schedules" do
      rc_transfer_schedule1 = Factory(:rc_transfer_schedule, :code => 'ABCD90', :approval_status => "A")
      find_rc_transfer_schedules({:code => 'ABCD90'}).should == [rc_transfer_schedule1]
      find_rc_transfer_schedules({:code => 'abcd90'}).should == [rc_transfer_schedule1]
      find_rc_transfer_schedules({:code => 'Abcd90'}).should == [rc_transfer_schedule1]
      find_rc_transfer_schedules({:code => 'Abcd 90'}).should == []
    end
  end  
end
