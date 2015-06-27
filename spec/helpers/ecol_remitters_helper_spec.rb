require 'spec_helper'

describe EcolRemittersHelper do

  context "filter_ecol_remitter" do 
    it "should return ecol_remitters" do 
      ecol_remitter = Factory(:ecol_remitter, :approval_status => 'U')
      filter_ecol_remitter({:approval_status => 'U'}).should == [ecol_remitter]
      filter_ecol_remitter({}).should == [] 
    end
  end
  
  context "find_ecol_remitters" do 
    it "should return ecol remitters" do
      ecol_customer = Factory(:ecol_customer, :code => 'CUST00', :approval_status => 'A')
      ecol_remitter = Factory(:ecol_remitter, :customer_code => "CUST00", :approval_status => 'A')
      find_ecol_remitters(EcolRemitter,{:customer_code => "CUST00"}).should == [ecol_remitter]
      find_ecol_remitters(EcolRemitter,{:customer_code => "CUST01"}).should == [] 
      
      ecol_remitter = Factory(:ecol_remitter, :customer_subcode => "SC", :approval_status => 'A')
      find_ecol_remitters(EcolRemitter,{:customer_subcode => "SC"}).should == [ecol_remitter]
      find_ecol_remitters(EcolRemitter,{:customer_subcode => "CS"}).should == [] 
      
      ecol_customer = Factory(:ecol_customer, :code => 'CUST10', :approval_status => 'A')
      ecol_remitter = Factory(:ecol_remitter, :customer_code => 'CUST10', :remitter_code => "RC", :approval_status => 'A')
      find_ecol_remitters(EcolRemitter,{:remitter_code => "RC"}).should == [ecol_remitter]
      find_ecol_remitters(EcolRemitter,{:remitter_code => "CR"}).should == []           
    end
  end
end
