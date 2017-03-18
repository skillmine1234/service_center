require 'spec_helper'
require 'flexmock/test_unit'

describe IamCustUser do
  include HelperMethods
  
  before(:each) do
    mock_ldap
  end

  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context "validation" do
    [:username, :first_name, :email, :mobile_no].each do |att|
      it { should validate_presence_of(att) }
    end

    it { should validate_uniqueness_of(:username).scoped_to(:approval_status) }

    it { should validate_numericality_of(:mobile_no) }
  end

  context "generate_password" do
    it "should generate password" do
      iam_cust_user = Factory(:iam_cust_user)
      iam_cust_user.generated_password.should_not be_nil
      iam_cust_user.encrypted_password.should_not be_nil
    end
  end

  context "add_user_to_ldap" do
    it "should add user to ldap" do
      iam_cust_user = Factory(:iam_cust_user, approval_status: 'A')
      iam_cust_user.add_user_to_ldap_on_approval.should_not raise_error
    end
  end

  context "default_scope" do 
    it "should only return 'A' records by default" do 
      iam_cust_user1 = Factory(:iam_cust_user, :approval_status => 'A') 
      iam_cust_user2 = Factory(:iam_cust_user, :first_name => 'MyString')
      IamCustUser.all.should == [iam_cust_user1]
      iam_cust_user2.approval_status = 'A'
      iam_cust_user2.save
      IamCustUser.all.should == [iam_cust_user1,iam_cust_user2]
    end
  end    

  context "unapproved_records" do 
    it "oncreate: should create unapproved_record if the approval_status is 'U'" do
      iam_cust_user = Factory(:iam_cust_user)
      iam_cust_user.reload
      iam_cust_user.unapproved_record_entry.should_not be_nil
    end

    it "oncreate: should not create unapproved_record if the approval_status is 'A'" do
      iam_cust_user = Factory(:iam_cust_user, :approval_status => 'A')
      iam_cust_user.unapproved_record_entry.should be_nil
    end

    it "onupdate: should not remove unapproved_record if approval_status did not change from U to A" do
      iam_cust_user = Factory(:iam_cust_user)
      iam_cust_user.reload
      iam_cust_user.unapproved_record_entry.should_not be_nil
      record = iam_cust_user.unapproved_record_entry
      # we are editing the U record, before it is approved
      iam_cust_user.username = 'Foo123'
      iam_cust_user.save
      iam_cust_user.reload
      iam_cust_user.unapproved_record_entry.should == record
    end

    it "onupdate: should remove unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      iam_cust_user = Factory(:iam_cust_user)
      iam_cust_user.reload
      iam_cust_user.unapproved_record_entry.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      iam_cust_user.approval_status = 'A'
      iam_cust_user.save
      iam_cust_user.reload
      iam_cust_user.unapproved_record_entry.should be_nil
    end

    it "ondestroy: should remove unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      iam_cust_user = Factory(:iam_cust_user)
      iam_cust_user.reload
      iam_cust_user.unapproved_record_entry.should_not be_nil
      record = iam_cust_user.unapproved_record_entry
      # the approval process destroys the U record, for an edited record 
      iam_cust_user.destroy
      UnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      iam_cust_user = Factory(:iam_cust_user, :approval_status => 'U')
      iam_cust_user.approve.should == ""
      iam_cust_user.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      iam_cust_user = Factory(:iam_cust_user, :approval_status => 'A')
      iam_cust_user1 = Factory(:iam_cust_user, :approval_status => 'U', :approved_id => iam_cust_user.id, :approved_version => 6)
      iam_cust_user1.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      iam_cust_user1 = Factory(:iam_cust_user, :approval_status => 'A')
      iam_cust_user2 = Factory(:iam_cust_user, :approval_status => 'U')
      iam_cust_user1.enable_approve_button?.should == false
      iam_cust_user2.enable_approve_button?.should == true
    end
  end
end
