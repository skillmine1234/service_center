require 'spec_helper'

describe PcFeeRulesHelper do
  context "find_pc_fee_rules" do
    it "should find pc_fee_rules" do
      pc_program = Factory(:pc_program, :approval_status => 'A')
      pc_fee_rule = Factory(:pc_fee_rule, :pc_program_id => pc_program.id, :approval_status => 'A')
      find_pc_fee_rules({:pc_program_id => pc_fee_rule.pc_program_id}).should == [pc_fee_rule]
      find_pc_fee_rules({:pc_program_id => '1111'}).should == []
    end
  end
end
