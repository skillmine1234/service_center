require 'spec_helper'

describe RcTransferSchedulesHelper do
  context "find_rc_transfer_schedules" do
    it "should find rc_transfer_schedules" do
      rc_transfer_schedule1 = Factory(:rc_transfer_schedule, :code => '1234', :approval_status => "A")
      find_rc_transfer_schedules({:code => '1234'}).should == [rc_transfer_schedule1]
      find_rc_transfer_schedules({:code => '1233453'}).should == []

      rc_transfer_schedule2 = Factory(:rc_transfer_schedule, :is_enabled => "Y", :approval_status => 'A')
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

      rc_transfer_schedule7 = Factory(:rc_transfer_schedule, :next_run_at => Time.zone.now, :approval_status => 'A')
      find_rc_transfer_schedules({:next_from_date => Time.zone.now.advance(:hours => -3).to_s, :next_to_date => Time.zone.now.advance(:hours => 3).to_s}).should == [rc_transfer_schedule7]
      find_rc_transfer_schedules({:next_from_date => Time.zone.now.advance(:hours => -3).to_s, :next_to_date => Time.zone.now.advance(:hours => -1).to_s}).should == []

      rc_transfer_schedule8 = Factory(:rc_transfer_schedule, :last_run_at => Time.zone.now, :approval_status => 'A')
      find_rc_transfer_schedules({:last_from_date => Time.zone.now.advance(:hours => -3).to_s, :last_to_date => Time.zone.now.advance(:hours => 3).to_s}).should == [rc_transfer_schedule8]
      find_rc_transfer_schedules({:last_from_date => Time.zone.now.advance(:hours => -3).to_s, :last_to_date => Time.zone.now.advance(:hours => -1).to_s}).should == []
    end
  end  
end
