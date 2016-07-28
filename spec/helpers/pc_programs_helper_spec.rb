require 'spec_helper'

describe PcProgramsHelper do
  context "find_pc_apps" do
    it "should find pc_programs" do
      pc_program = Factory(:pc_program, :code => 'ABCD90', :approval_status => 'A')
      find_pc_programs({:code => 'ABCD90'}).should == [pc_program]
      find_pc_programs({:code => 'abcd90'}).should == [pc_program]
      find_pc_programs({:code => 'Abcd90'}).should == [pc_program]
      find_pc_programs({:code => 'Abcd 90'}).should == []
    end
  end
end
