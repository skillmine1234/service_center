require 'spec_helper'

describe InwIdentity do
  context 'association' do
    it { should belong_to(:inward_remittance) }
  end

  context 'validation' do
    it { should validate_length_of(:id_type).is_at_most(30) }

    it "should validate the length of the id_type" do
      inw_identity = Factory(:inw_identity, :id_type => "Marraige Certificate")
      inw_identity.should be_valid
      inw_identity.errors_on(:id_type).should == []

      inw_identity = Factory.build(:inw_identity, :id_type => "Posted Mail with name of applicant")
      inw_identity.should_not be_valid
      inw_identity.errors_on(:id_type).should == ["is too long (maximum is 30 characters)"]
    end
  end

  context "whitelisted_identity" do 
    it "should return whitelisted_identity if present" do 
      whitelisted_identity = Factory(:whitelisted_identity, :approval_status => 'A')
      identity = Factory(:inw_identity)
      identity.whitelisted_identity.should == whitelisted_identity
    end

    it "should return nil if not present" do 
      whitelisted_identity = Factory(:whitelisted_identity, :id_type => 'License', :approval_status => 'A')
      identity = Factory(:inw_identity)
      identity.whitelisted_identity.should == nil
    end
  end

  context "is_verified" do 
    it "should return 'Y' if whitelisted_identity is present" do 
      whitelisted_identity = Factory(:whitelisted_identity, :approval_status => 'A')
      identity = Factory(:inw_identity)
      identity.is_verified.should == 'Y'
    end
    
    it "should return 'N' if whitelisted_identity is not present" do 
      whitelisted_identity = Factory(:whitelisted_identity, :id_type => 'License', :approval_status => 'A')
      identity = Factory(:inw_identity)
      identity.is_verified.should == 'N'
    end
  end

  context "verified_by" do 
    it "should return verified_by if whitelisted_identity is present" do 
      whitelisted_identity = Factory(:whitelisted_identity, :approval_status => 'A')
      identity = Factory(:inw_identity)
      identity.verified_by.should == whitelisted_identity.verified_by.to_s
    end
    
    it "should return '-' if whitelisted_identity is not present" do 
      whitelisted_identity = Factory(:whitelisted_identity, :id_type => 'License', :approval_status => 'A')
      identity = Factory(:inw_identity)
      identity.verified_by.should == '-'
    end
  end

  context "verified_at" do 
    it "should return verified_at if whitelisted_identity is present" do 
      whitelisted_identity = Factory(:whitelisted_identity, :approval_status => 'A')
      identity = Factory(:inw_identity)
      identity.verified_at.should == whitelisted_identity.verified_at.strftime("%d/%m/%Y %I:%M%p")
    end
    
    it "should return '-' if whitelisted_identity is not present" do 
      whitelisted_identity = Factory(:whitelisted_identity, :id_type => 'License', :approval_status => 'A')
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
end