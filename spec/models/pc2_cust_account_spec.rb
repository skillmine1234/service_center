require 'spec_helper'

describe Pc2CustAccount do  
  include HelperMethods

  context "associations" do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:pc2_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
    it { should belong_to(:pc2_app) }
  end

  context 'validation' do
    [:customer_id, :account_no, :is_enabled].each do |att|
      it { should validate_presence_of(att) }
    end

    it do 
      pc2_cust_account = Factory(:pc2_cust_account, :approval_status => 'A')
      should validate_uniqueness_of(:customer_id).scoped_to(:account_no, :approval_status)
    end

    it "should not allow invalid format" do
      pc2_cust_account = Factory.build(:pc2_cust_account, :customer_id => "sfdsg", :account_no => "dfsd343")
      pc2_cust_account.save == false
      pc2_cust_account.errors_on(:customer_id).should == ["Invalid format, expected format is : {[0-9]}", "not valid"]
      pc2_cust_account.errors_on(:account_no).should == ["Invalid format, expected format is : {[0-9]}"]
    end

    it "should validate length" do
      pc2_cust_account = Factory(:pc2_cust_account, :approval_status => 'A')
      should validate_length_of(:customer_id).is_at_most(15)
      should validate_length_of(:account_no).is_at_least(5).is_at_most(20)
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      pc2_cust_account1 = Factory(:pc2_cust_account, :approval_status => 'A') 
      pc2_cust_account2 = Factory(:pc2_cust_account)
      Pc2CustAccount.all.should == [pc2_cust_account1]
      pc2_cust_account2.approval_status = 'A'
      pc2_cust_account2.save
      Pc2CustAccount.all.should == [pc2_cust_account1, pc2_cust_account2]
    end
  end

  context 'validate_customer_id' do
    it 'should throw an error if pc2_apps records with given customer_id and is_enabled "Y" are not present' do
      pc2_app1 = Factory(:pc2_app, :approval_status => 'A', :is_enabled => 'N', :customer_id => '1111')
      pc2_app2 = Factory(:pc2_app, :approval_status => 'A', :is_enabled => 'N', :customer_id => '1112')
      pc2_app3 = Factory(:pc2_app, :approval_status => 'A', :is_enabled => 'Y', :customer_id => '1113')

      pc2_cust_account = Factory.build(:pc2_cust_account, :customer_id => '1111')
      pc2_cust_account.save == false
      pc2_cust_account.errors_on(:customer_id).should == ["not valid"]

      pc2_cust_account = Factory.build(:pc2_cust_account, :customer_id => '1114')
      pc2_cust_account.save == false
      pc2_cust_account.errors_on(:customer_id).should == ["not valid"]
    end

    it 'should not throw an error if pc2_apps records with given customer_id and is_enabled "Y" are present' do
      pc2_app1 = Factory(:pc2_app, :approval_status => 'A', :is_enabled => 'Y', :customer_id => '2111')
      pc2_app2 = Factory(:pc2_app, :approval_status => 'A', :is_enabled => 'N', :customer_id => '2112')

      pc2_cust_account = Factory.build(:pc2_cust_account, :customer_id => '2111')
      pc2_cust_account.save == true
      pc2_cust_account.errors_on(:customer_id).should == []
    end
  end

  context "pc2_unapproved_records" do 
    it "oncreate: should create pc2_unapproved_record if the approval_status is 'U'" do
      pc2_cust_account = Factory(:pc2_cust_account)
      pc2_cust_account.reload
      pc2_cust_account.pc2_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create pc2_unapproved_record if the approval_status is 'A'" do
      pc2_cust_account = Factory(:pc2_cust_account, :approval_status => 'A')
      pc2_cust_account.pc2_unapproved_record.should be_nil
    end

    it "onupdate: should not remove pc2_unapproved_record if approval_status did not change from U to A" do
      pc2_cust_account = Factory(:pc2_cust_account)
      pc2_cust_account.reload
      pc2_cust_account.pc2_unapproved_record.should_not be_nil
      record = pc2_cust_account.pc2_unapproved_record
      # we are editing the U record, before it is approved
      pc2_cust_account.customer_id = 'Fooo'
      pc2_cust_account.save
      pc2_cust_account.reload
      pc2_cust_account.pc2_unapproved_record.should == record
    end
    
    it "onupdate: should remove pc2_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      pc2_cust_account = Factory(:pc2_cust_account)
      pc2_cust_account.reload
      pc2_cust_account.pc2_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      pc2_cust_account.approval_status = 'A'
      pc2_cust_account.save
      pc2_cust_account.reload
      pc2_cust_account.pc2_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove pc2_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      pc2_cust_account = Factory(:pc2_cust_account)
      pc2_cust_account.reload
      pc2_cust_account.pc2_unapproved_record.should_not be_nil
      record = pc2_cust_account.pc2_unapproved_record
      # the approval process destroys the U record, for an edited record 
      pc2_cust_account.destroy
      Pc2UnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      pc2_cust_account = Factory(:pc2_cust_account, :approval_status => 'U')
      pc2_cust_account.approve.should == ""
      pc2_cust_account.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      pc2_cust_account = Factory(:pc2_cust_account, :approval_status => 'A')
      pc2_cust_account2 = Factory(:pc2_cust_account, :approval_status => 'U', :approved_id => pc2_cust_account.id, :approved_version => 6)
      pc2_cust_account2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      pc2_cust_account1 = Factory(:pc2_cust_account, :approval_status => 'A')
      pc2_cust_account2 = Factory(:pc2_cust_account, :approval_status => 'U')
      pc2_cust_account1.enable_approve_button?.should == false
      pc2_cust_account2.enable_approve_button?.should == true
    end
  end
end
