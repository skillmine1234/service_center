require 'spec_helper'

describe PcFeeRulesHelper do
  context "find_pc_fee_rules" do
    it "should find pc_fee_rules" do
      pc_program = Factory(:pc_program, :approval_status => 'A')
      pc_fee_rule = Factory(:pc_fee_rule, :program_code => pc_program.code, :approval_status => 'A')
      find_pc_fee_rules({:program_code => pc_fee_rule.program_code}).should == [pc_fee_rule]
      find_pc_fee_rules({:program_code => '1111'}).should == []
    end
  end
end
