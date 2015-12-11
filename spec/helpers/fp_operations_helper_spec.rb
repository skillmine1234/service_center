require 'spec_helper'

describe FpOperationsHelper do
  context "find_fp_operations" do
    it "should find fp_operations" do
      fp_operation = Factory(:fp_operation, :operation_name => '1234', :approval_status => 'A')
      find_fp_operations({:operation_name => '1234'}).should == [fp_operation]
      find_fp_operations({:operation_name => '1111'}).should == []
    end
  end
end
