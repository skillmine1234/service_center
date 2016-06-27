require 'spec_helper'

describe SmBanksHelper do
  context "find_sm_banks" do
    it "should find sm_banks" do
      sm_bank1 = Factory(:sm_bank, :code => 'ABCD90', :approval_status => "A")
      find_sm_banks({:code => 'ABCD90'}).should == [sm_bank1]
      find_sm_banks({:code => 'abcd90'}).should == [sm_bank1]
      find_sm_banks({:code => 'Abcd90'}).should == [sm_bank1]
      find_sm_banks({:code => 'Abcd 90'}).should == []

      sm_bank2 = Factory(:sm_bank, :code => "ABCD91", :is_enabled => "Y", :approval_status => 'A')
      find_sm_banks({:is_enabled => "Y"}).should == [sm_bank1, sm_bank2]
      find_sm_banks({:is_enabled => "N"}).should == [] 

      sm_bank3 = Factory(:sm_bank, :name => 'ABCD Co', :approval_status => "A")
      find_sm_banks({:name => 'ABCD Co'}).should == [sm_bank3]
      find_sm_banks({:name => 'abcd co'}).should == [sm_bank3]
      find_sm_banks({:name => 'abcd-co'}).should == []
      find_sm_banks({:name => 'abcd  co'}).should == []
      find_sm_banks({:name => 'abcd co.'}).should == []
      find_sm_banks({:name => 'abcdco.'}).should == []

      sm_bank4 = Factory(:sm_bank, :bank_code => 'ABCD0123458', :approval_status => "A")
      find_sm_banks({:bank_code => 'ABCD0123458'}).should == [sm_bank4]
      find_sm_banks({:bank_code => 'abcd0123458'}).should == [sm_bank4]
      find_sm_banks({:bank_code => 'abcd 0123458'}).should == []
      find_sm_banks({:bank_code => 'abcd'}).should == []
      find_sm_banks({:bank_code => 'abcd01'}).should == []
    end
  end  
end
