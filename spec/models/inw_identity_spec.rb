require 'spec_helper'

describe InwIdentity do
  context 'association' do
    it { should belong_to(:created_user)}
    it { should belong_to(:updated_user)}
  end

  context 'validation' do
    [:partner_id, :created_by, :updated_by].each do |att|
      it { should validate_presence_of(att) }
    end
  end

  context "whitelisted_identity" do 
    it "should return whitelisted_identity if present" do 
      whitelisted_identity = Factory(:whitelisted_identity)
      identity = Factory(:inw_identity)
      identity.whitelisted_identity.should == whitelisted_identity
    end

    it "should return nil if not present" do 
      whitelisted_identity = Factory(:whitelisted_identity, :full_name => 'Bar Foo')
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
      whitelisted_identity = Factory(:whitelisted_identity, :full_name => 'Bar Foo')
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
      whitelisted_identity = Factory(:whitelisted_identity, :full_name => 'Bar Foo')
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
      whitelisted_identity = Factory(:whitelisted_identity, :full_name => 'Bar Foo')
      identity = Factory(:inw_identity)
      identity.verified_at.should == '-'
    end
  end
end
