require 'spec_helper'

describe EcolRemittersHelper do
  include HelperMethods

  before(:each) do
    mock_ldap
  end

  context "filter_ecol_remitter" do 
    it "should return ecol_remitters" do 
      ecol_remitter = Factory(:ecol_remitter, :approval_status => 'U')
      filter_ecol_remitter({:approval_status => 'U'}).should == [ecol_remitter]
      filter_ecol_remitter({}).should == [] 
    end
  end
  
  context "find_ecol_remitters" do 
    it "should return ecol remitters" do
      ecol_customer = Factory(:ecol_customer, :code => 'CUST0001', :approval_status => 'A')
      ecol_remitter = Factory(:ecol_remitter, :customer_code => "CUST0001", :approval_status => 'A')
      find_ecol_remitters(EcolRemitter,{:customer_code => "CUST0001"}).should == [ecol_remitter]
      find_ecol_remitters(EcolRemitter,{:customer_code => "CUST0110"}).should == [] 
      
      ecol_remitter = Factory(:ecol_remitter, :customer_subcode => "SC", :approval_status => 'A')
      find_ecol_remitters(EcolRemitter,{:customer_subcode => "SC"}).should == [ecol_remitter]
      find_ecol_remitters(EcolRemitter,{:customer_subcode => "CS"}).should == [] 
      
      ecol_customer = Factory(:ecol_customer, :code => 'CUST1000', :approval_status => 'A')
      ecol_remitter = Factory(:ecol_remitter, :customer_code => 'CUST1000', :remitter_code => "RC", :approval_status => 'A')
      find_ecol_remitters(EcolRemitter,{:remitter_code => "RC"}).should == [ecol_remitter]
      find_ecol_remitters(EcolRemitter,{:remitter_code => "CR"}).should == []           
    end
  end

  context "created_or_edited_by" do 
    it "should return created by" do 
      user = Factory(:user)
      ecol_remitter = Factory(:ecol_remitter, :approval_status => 'U', :created_by => user.id)
      created_or_edited_by(ecol_remitter).should == "New Record Created By #{ecol_remitter.created_user.try(:name)}"
    end

    it "should return edited by" do 
      user = Factory(:user)
      user2 = Factory(:user)
      ecol_remitter = Factory(:ecol_remitter, :approval_status => 'A')
      ecol_remitter2 = Factory(:ecol_remitter,:approved_id => ecol_remitter.id, :created_by => user.id)
      created_or_edited_by(ecol_remitter2).should == "Record Edited By #{ecol_remitter2.created_user.try(:name)}"
      ecol_remitter2.updated_by = user2.id
      ecol_remitter2.save
      created_or_edited_by(ecol_remitter2).should == "Record Edited By #{ecol_remitter2.updated_user.try(:name)}"
    end
  end
end
