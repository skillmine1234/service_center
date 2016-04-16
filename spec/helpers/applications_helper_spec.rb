require 'spec_helper'

describe ApplicationHelper do
  context "has_route?" do
    it "should return true if there is a route present" do 
      options = {:controller => "su_incoming_records", :action => 'incoming_file_summary'}
      helper.has_route?(options).should == true
    end
  end
end