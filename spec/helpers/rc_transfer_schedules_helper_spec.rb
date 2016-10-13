require 'spec_helper'

describe RcTransferSchedulesHelper do
  context "find_rc_transfer_schedules" do
    it "should find rc_transfer_schedules" do
      rc_transfer_schedule1 = Factory(:rc_transfer_schedule, :code => 'ABCD90', :approval_status => "A")
      find_rc_transfer_schedules({:code => 'ABCD90'}).should == [rc_transfer_schedule1]
      find_rc_transfer_schedules({:code => 'abcd90'}).should == [rc_transfer_schedule1]
      find_rc_transfer_schedules({:code => 'Abcd90'}).should == [rc_transfer_schedule1]
      find_rc_transfer_schedules({:code => 'Abcd 90'}).should == []

      rc_transfer_schedule2 = Factory(:rc_transfer_schedule, :code => "ABCD91", :is_enabled => "Y", :approval_status => 'A')
      find_rc_transfer_schedules({:is_enabled => "Y"}).should == [rc_transfer_schedule1, rc_transfer_schedule2]
      find_rc_transfer_schedules({:is_enabled => "N"}).should == [] 

      rc_transfer_schedule3 = Factory(:rc_transfer_schedule, :debit_account_no => "112233445566778", :approval_status => 'A')
      find_rc_transfer_schedules({:debit_account_no => "112233445566778"}).should == [rc_transfer_schedule3]
      find_rc_transfer_schedules({:debit_account_no => "112233445566779"}).should == [] 
      find_rc_transfer_schedules({:debit_account_no => "1122334455667"}).should == [] 

      rc_transfer_schedule4 = Factory(:rc_transfer_schedule, :bene_account_no => "223344556677811", :approval_status => 'A')
      find_rc_transfer_schedules({:bene_account_no => "223344556677811"}).should == [rc_transfer_schedule4]
      find_rc_transfer_schedules({:bene_account_no => "223344556677812"}).should == [] 
      find_rc_transfer_schedules({:bene_account_no => "2233445566778"}).should == [] 

      rc_transfer_schedule5 = Factory(:rc_transfer_schedule, :notify_mobile_no => "9999221133", :approval_status => 'A')
      find_rc_transfer_schedules({:notify_mobile_no => "9999221133"}).should == [rc_transfer_schedule5]
      find_rc_transfer_schedules({:notify_mobile_no => "9999221134"}).should == [] 
      find_rc_transfer_schedules({:notify_mobile_no => "999922113"}).should == [] 

      rc_transfer_schedule5 = Factory(:rc_transfer_schedule, :notify_mobile_no => "9999221144", :approval_status => 'A')
      find_rc_transfer_schedules({:notify_mobile_no => "9999221144"}).should == [rc_transfer_schedule5]
      find_rc_transfer_schedules({:notify_mobile_no => "9999221145"}).should == [] 
      find_rc_transfer_schedules({:notify_mobile_no => "999922114"}).should == [] 
    end
  end  
end
