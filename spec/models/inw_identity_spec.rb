require 'spec_helper'

describe InwIdentity do
  context 'association' do
    it { should belong_to(:inward_remittance) }
  end

  context "whitelisted_identity" do 
    it "should return whitelisted_identity if present" do 
      whitelisted_identity = Factory(:whitelisted_identity)
      identity = Factory(:inw_identity)
      identity.whitelisted_identity.should == whitelisted_identity
    end

    it "should return nil if not present" do 
      whitelisted_identity = Factory(:whitelisted_identity, :id_type => 'License')
      identity = Factory(:inw_identity)
      identity.whitelisted_identity.should == nil
    end
  end

  context "is_verified" do 
    it "should return 'Y' if whitelisted_identity is present" do 
      whitelisted_identity = Factory(:whitelisted_identity)
      identity = Factory(:inw_identity)
      identity.is_verified.should == 'Y'
    end
    
    it "should return 'N' if whitelisted_identity is not present" do 
      whitelisted_identity = Factory(:whitelisted_identity, :id_type => 'License')
      identity = Factory(:inw_identity)
      identity.is_verified.should == 'N'
    end
  end

  context "verified_by" do 
    it "should return verified_by if whitelisted_identity is present" do 
      whitelisted_identity = Factory(:whitelisted_identity)
      identity = Factory(:inw_identity)
      identity.verified_by.should == whitelisted_identity.verified_by.to_s
    end
    
    it "should return '-' if whitelisted_identity is not present" do 
      whitelisted_identity = Factory(:whitelisted_identity, :id_type => 'License')
      identity = Factory(:inw_identity)
      identity.verified_by.should == '-'
    end
  end

  context "verified_at" do 
    it "should return verified_at if whitelisted_identity is present" do 
      whitelisted_identity = Factory(:whitelisted_identity)
      identity = Factory(:inw_identity)
      identity.verified_at.should == whitelisted_identity.verified_at.strftime("%d/%m/%Y %I:%M%p")
    end
    
    it "should return '-' if whitelisted_identity is not present" do 
      whitelisted_identity = Factory(:whitelisted_identity, :id_type => 'License')
      identity = Factory(:inw_identity)
      identity.verified_at.should == '-'
    end
  end

  context "full_name" do 
    it "should return remitter full name if the id_for is 'R'" do 
      identity = Factory(:inw_identity)
      identity.full_name.should == identity.inward_remittance.rmtr_full_name
    end

    it "should return beneficiary full name if the id_for is not 'R'" do 
      identity = Factory(:inw_identity)
      identity.full_name.should == identity.inward_remittance.bene_full_name
    end
  end

  context "first_name" do 
    it "should return remitter first name if the id_for is 'R'" do 
      identity = Factory(:inw_identity)
      identity.first_name.should == identity.inward_remittance.rmtr_first_name
    end

    it "should return beneficiary first name if the id_for is not 'R'" do 
      identity = Factory(:inw_identity)
      identity.first_name.should == identity.inward_remittance.bene_first_name
    end
  end

  context "last_name" do 
    it "should return remitter last name if the id_for is 'R'" do 
      identity = Factory(:inw_identity)
      identity.last_name.should == identity.inward_remittance.rmtr_last_name
    end

    it "should return beneficiary full name if the id_for is not 'R'" do 
      identity = Factory(:inw_identity)
      identity.last_name.should == identity.inward_remittance.bene_last_name
    end
  end
end
