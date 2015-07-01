require 'spec_helper'

describe UdfAttributeHelper do
  
  context "label_value" do
    it "returns values for labels in the form" do
      label_value(:min_length).should == 'Min Length'
      label_value(:max_length).should == 'Max Length'
      label_value(:min_value).should == 'Min Value'
      label_value(:max_value).should == 'Max Value'
    end
  end
  
end