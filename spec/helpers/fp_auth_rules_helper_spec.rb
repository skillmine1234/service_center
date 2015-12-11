require 'spec_helper'

describe FpAuthRulesHelper do
  context "find_fp_auth_rules" do
    it "should find fp_auth_rules" do
      fp_auth_rule = Factory(:fp_auth_rule, :operation_name => '1234', :approval_status => 'A')
      find_fp_auth_rules({:operation_name => '1234'}).should == [fp_auth_rule]
      find_fp_auth_rules({:operation_name => '1111'}).should == []
    end
  end
end
