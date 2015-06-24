require 'spec_helper'

describe EcolRemittersHelper do
  
  context "find_ecol_remitters" do 
    it "should return ecol remitters" do
      ecol_customer = Factory(:ecol_customer, :code => 'CUST00')
      ecol_remitter = Factory(:ecol_remitter, :customer_code => "CUST00")
      find_ecol_remitters(EcolRemitter,{:customer_code => "CUST00"}).should == [ecol_remitter]
      find_ecol_remitters(EcolRemitter,{:customer_code => "CUST01"}).should == [] 
      
      ecol_remitter = Factory(:ecol_remitter, :customer_subcode => "SC")
      find_ecol_remitters(EcolRemitter,{:customer_subcode => "SC"}).should == [ecol_remitter]
      find_ecol_remitters(EcolRemitter,{:customer_subcode => "CS"}).should == [] 
      
      ecol_remitter = Factory(:ecol_remitter, :remitter_code => "RC")
      find_ecol_remitters(EcolRemitter,{:remitter_code => "RC"}).should == [ecol_remitter]
      find_ecol_remitters(EcolRemitter,{:remitter_code => "CR"}).should == []      
    end
  end
end
