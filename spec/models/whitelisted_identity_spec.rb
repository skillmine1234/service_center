require 'spec_helper'

describe WhitelistedIdentity do
  context 'association' do
    it { should have_many(:attachments)}
    it { should belong_to(:created_user)}
    it { should belong_to(:updated_user)}
    it { should belong_to(:inward_remittance)}
    it { should belong_to(:partner)}
  end

  context 'validation' do
    [:partner_id, :is_verified, :created_by, :updated_by].each do |att|
      it { should validate_presence_of(att) }
    end
  end

  context "inw_identity" do 
    it "should return identity if found" do 
      inward_remittance = Factory(:inward_remittance)
      whitelisted_identity = Factory(:whitelisted_identity, :first_used_with_txn_id => inward_remittance.id)
      identity = Factory(:inw_identity, :inw_remittance_id => inward_remittance.id)
      identity.id_issue_date = whitelisted_identity.id_issue_date
      identity.id_expiry_date = whitelisted_identity.id_expiry_date
      identity.id_type = whitelisted_identity.id_type
      identity.id_number = whitelisted_identity.id_number
      identity.id_country = whitelisted_identity.id_country
      whitelisted_identity.inw_identity.should == identity
    end

    it "should return nill if identity not found" do 
      inward_remittance = Factory(:inward_remittance)
      whitelisted_identity = Factory(:whitelisted_identity, :first_used_with_txn_id => inward_remittance.id)
      whitelisted_identity.inw_identity.should == nil
    end
  end

  context "update_identities" do 
    it "should return identity if found" do 
      inward_remittance = Factory(:inward_remittance)
      identity = Factory(:inw_identity, :inw_remittance_id => inward_remittance.id, :was_auto_matched => nil)
      whitelisted_identity = Factory(:whitelisted_identity, :first_used_with_txn_id => inward_remittance.id,
                                     :id_issue_date => identity.id_issue_date,
                                     :id_expiry_date => identity.id_expiry_date,
                                     :id_type => identity.id_type,
                                     :id_number => identity.id_number,
                                     :id_country => identity.id_country)
      identity.reload
      identity.was_auto_matched.should == 'N'
      identity.whitelisted_identity_id.should == whitelisted_identity.id
    end
  end
end