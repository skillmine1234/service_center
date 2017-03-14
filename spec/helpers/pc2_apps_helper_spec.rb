require 'spec_helper'

describe Pc2AppsHelper do
  include HelperMethods
  
  before(:each) do
    mock_ldap
  end

  context "find_pc2_apps" do
    it "should find pc2_apps" do
      pc2_app = Factory(:pc2_app, :app_id => "1111", :approval_status => "A")
      find_pc2_apps({:app_id => "1111"}).should == [pc2_app]
      find_pc2_apps({:app_id => "1100"}).should == []
    end
  end
end
