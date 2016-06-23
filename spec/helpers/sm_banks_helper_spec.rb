require 'spec_helper'

describe SmBanksHelper do
  context "find_sm_banks" do
    it "should find sm_banks" do
      sm_bank = Factory(:sm_bank, :code => 'ABCD90', :approval_status => "A")
      find_sm_banks({:code => 'ABCD90'}).should == [sm_bank]
      find_sm_banks({:code => 'abcd90'}).should == [sm_bank]
      find_sm_banks({:code => 'Abcd90'}).should == [sm_bank]
      find_sm_banks({:code => 'Abcd 90'}).should == []

      sm_bank = Factory(:sm_bank, :name => 'ABCD Co', :approval_status => "A")
      find_sm_banks({:name => 'ABCD Co'}).should == [sm_bank]
      find_sm_banks({:name => 'abcd co'}).should == [sm_bank]

      sm_bank = Factory(:sm_bank, :bank_code => 'ABCD0123458', :approval_status => "A")
      find_sm_banks({:bank_code => 'ABCD0123458'}).should == [sm_bank]
      find_sm_banks({:bank_code => 'abcd0123458'}).should == [sm_bank]
    end
  end  
end
