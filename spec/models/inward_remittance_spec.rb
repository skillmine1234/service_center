require 'spec_helper'

describe InwardRemittance do
  context 'association' do
    it { should have_one(:partner) }
    it { should have_one(:purpose) }
    it { should have_many(:remitter_identities) }
    it { should have_many(:beneficiary_identities) }
  end

  context 'validation' do
    [:req_no, :req_version, :req_timestamp, :partner_code, :rmtr_identity_count, :bene_identity_count, :attempt_no].each do |att|
      it { should validate_presence_of(att) }
    end
  end

  context "remitter_address" do 
    it "should return remitter_address" do 
      inward_remittance = Factory(:inward_remittance, :rmtr_address1 => 'addr1', :rmtr_address2 => 'addr2', :rmtr_address3 => 'addr3')
      inward_remittance.remitter_address.should == "addr1 addr2 addr3"
    end
  end

  context "beneficiary_address" do 
    it "should return beneficiary_address" do 
      inward_remittance = Factory(:inward_remittance, :bene_address1 => 'addr1', :bene_address2 => 'addr2', :bene_address3 => 'addr3')
      inward_remittance.beneficiary_address.should == "addr1 addr2 addr3"
    end
  end
end
