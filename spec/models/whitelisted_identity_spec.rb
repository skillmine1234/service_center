require 'spec_helper'

describe WhitelistedIdentity do
  context 'association' do
    it { should have_many(:attachments)}
    it { should belong_to(:created_user)}
    it { should belong_to(:updated_user)}
    it { should belong_to(:inward_remittance)}
    it { should belong_to(:partner)}
    it { should have_one(:inw_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end

  context 'validation' do
    [:partner_id, :is_verified, :created_by, :updated_by, 
     :id_type, :id_number,:id_country,:id_issue_date,:id_expiry_date].each do |att|
      it { should validate_presence_of(att) }
    end
    
    it do
      whitelisted_identity = Factory(:whitelisted_identity, :approval_status => 'A')
      should validate_uniqueness_of(:id_type).scoped_to(:id_number,:id_country,:id_issue_date,:id_expiry_date,:approval_status)
    end
    
    it "should validate_unapproved_record" do 
      whitelisted_identity1 = Factory(:whitelisted_identity,:approval_status => 'A')
      whitelisted_identity2 = Factory(:whitelisted_identity, :approved_id => whitelisted_identity1.id)
      whitelisted_identity1.should_not be_valid
      whitelisted_identity1.errors_on(:base).should == ["Unapproved Record Already Exists for this record"]
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
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      whitelisted_identity1 = Factory(:whitelisted_identity, :approval_status => 'A') 
      whitelisted_identity2 = Factory(:whitelisted_identity, :id_type => "Aadhar")
      WhitelistedIdentity.all.should == [whitelisted_identity1]
      whitelisted_identity2.approval_status = 'A'
      whitelisted_identity2.save
      WhitelistedIdentity.all.should == [whitelisted_identity1,whitelisted_identity2]
    end
  end    

  context "inw_unapproved_records" do 
    it "oncreate: should create inw_unapproved_record if the approval_status is 'U'" do
      whitelisted_identity = Factory(:whitelisted_identity)
      whitelisted_identity.reload
      whitelisted_identity.inw_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create inw_unapproved_record if the approval_status is 'A'" do
      whitelisted_identity = Factory(:whitelisted_identity, :approval_status => 'A')
      whitelisted_identity.inw_unapproved_record.should be_nil
    end

    it "onupdate: should not remove inw_unapproved_record if approval_status did not change from U to A" do
      whitelisted_identity = Factory(:whitelisted_identity)
      whitelisted_identity.reload
      whitelisted_identity.inw_unapproved_record.should_not be_nil
      record = whitelisted_identity.inw_unapproved_record
      # we are editing the U record, before it is approved
      whitelisted_identity.id_type = 'Aadhar'
      whitelisted_identity.save
      whitelisted_identity.reload
      whitelisted_identity.inw_unapproved_record.should == record
    end
    
    it "onupdate: should remove inw_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      whitelisted_identity = Factory(:whitelisted_identity)
      whitelisted_identity.reload
      whitelisted_identity.inw_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      whitelisted_identity.approval_status = 'A'
      whitelisted_identity.save
      whitelisted_identity.reload
      whitelisted_identity.inw_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove inw_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      whitelisted_identity = Factory(:whitelisted_identity)
      whitelisted_identity.reload
      whitelisted_identity.inw_unapproved_record.should_not be_nil
      record = whitelisted_identity.inw_unapproved_record
      # the approval process destroys the U record, for an edited record 
      whitelisted_identity.destroy
      InwUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      whitelisted_identity = Factory(:whitelisted_identity, :approval_status => 'U')
      whitelisted_identity.approve.should == ""
      whitelisted_identity.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      whitelisted_identity = Factory(:whitelisted_identity, :approval_status => 'A')
      whitelisted_identity2 = Factory(:whitelisted_identity, :approval_status => 'U', :approved_id => whitelisted_identity.id, :approved_version => 6)
      whitelisted_identity2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      whitelisted_identity1 = Factory(:whitelisted_identity, :approval_status => 'A')
      whitelisted_identity2 = Factory(:whitelisted_identity, :approval_status => 'U')
      whitelisted_identity1.enable_approve_button?.should == false
      whitelisted_identity2.enable_approve_button?.should == true
    end
  end
  
end