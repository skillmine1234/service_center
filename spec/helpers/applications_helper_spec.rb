require 'spec_helper'

describe ApplicationHelper do
  context "has_route?" do
    it "should return true if there is a route present" do 
      options = {:controller => "su_incoming_records", :action => 'incoming_file_summary'}
      helper.has_route?(options).should == true
    end
  end

  context "valid_date" do
    it "should return true if date is valid" do 
      helper.valid_date('12-2-2016').should == true
    end

    it "should return false if date is invalid" do 
      helper.valid_date('12-22016').should == false
    end
  end
end