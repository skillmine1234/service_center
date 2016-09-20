require 'spec_helper'

describe PcAppsHelper do
  context "find_pc_apps" do
    it "should find pc_apps" do
      pc_program = Factory(:pc_program, :approval_status => 'A', :code => 'pcapp1')
      pc_app = Factory(:pc_app, :program_code=> pc_program.code, :approval_status => 'A')
      find_pc_apps({:program_code => 'pcapp1'}).should == [pc_app]
      find_pc_apps({:program_code => 'PCapp1'}).should == [pc_app]
      find_pc_apps({:program_code => 'pcapp2'}).should == []

      pc_app = Factory(:pc_app, :app_id => '12345', :approval_status => 'A')
      find_pc_apps({:app_id => '12345'}).should == [pc_app]
      find_pc_apps({:app_id => '1111'}).should == []
    end
  end
end
