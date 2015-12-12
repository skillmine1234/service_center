require 'spec_helper'

describe PcAppsHelper do
  context "find_pc_apps" do
    it "should find pc_apps" do
      pc_app = Factory(:pc_app, :app_id => '1234', :approval_status => 'A')
      find_pc_apps({:app_id => '1234'}).should == [pc_app]
      find_pc_apps({:app_id => '1111'}).should == []
    end
  end
end