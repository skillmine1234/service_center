require 'spec_helper'

describe PcFeeRulesHelper do
  context "find_pc_fee_rules" do
    it "should find pc_fee_rules" do
      pc_app = Factory(:pc_app)
      pc_fee_rule = Factory(:pc_fee_rule, :approval_status => 'A')
      find_pc_fee_rules({:app_id => pc_fee_rule.app_id}).should == [pc_fee_rule]
      find_pc_fee_rules({:app_id => '1111'}).should == []
    end
  end
end
