require 'spec_helper'

describe FtCustomerAccount do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:ft_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end
  
  context 'validation' do
    [:customer_id, :account_no, :is_enabled].each do |att|
      it { should validate_presence_of(att) }
    end

    it do 
      ft_customer_account = Factory(:ft_customer_account, :approval_status => 'A')
      should validate_uniqueness_of(:customer_id).scoped_to(:account_no,:approval_status)  

      should validate_length_of(:account_no).is_at_most(20)
      should validate_length_of(:customer_id).is_at_least(3).is_at_most(15)
    end

    it "should not allow invalid format" do
      ft_customer = Factory.build(:ft_customer_account, :customer_id => "sfdsg", :account_no => "dfsd343")
      ft_customer.save == false
      ft_customer.errors_on(:customer_id).should == ["Invalid format, expected format is : {[0-9]}", "not valid"]
      ft_customer.errors_on(:account_no).should == ["Invalid format, expected format is : {[0-9]}"]
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      ft_customer_account1 = Factory(:ft_customer_account, :approval_status => 'A') 
      ft_customer_account2 = Factory(:ft_customer_account)
      FtCustomerAccount.all.should == [ft_customer_account1]
      ft_customer_account2.approval_status = 'A'
      ft_customer_account2.save
      FtCustomerAccount.all.should == [ft_customer_account1,ft_customer_account2]
    end
  end    

  context "ft_unapproved_records" do 
    it "oncreate: should create ft_unapproved_record if the approval_status is 'U'" do
      ft_customer_account = Factory(:ft_customer_account)
      ft_customer_account.reload
      ft_customer_account.ft_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create ft_unapproved_record if the approval_status is 'A'" do
      ft_customer_account = Factory(:ft_customer_account, :approval_status => 'A')
      ft_customer_account.ft_unapproved_record.should be_nil
    end

    it "onupdate: should not remove ft_unapproved_record if approval_status did not change from U to A" do
      ft_customer_account = Factory(:ft_customer_account)
      ft_customer_account.reload
      ft_customer_account.ft_unapproved_record.should_not be_nil
      record = ft_customer_account.ft_unapproved_record
      # we are editing the U record, before it is approved
      ft_customer_account.account_no = "1234"
      ft_customer_account.save
      ft_customer_account.reload
      ft_customer_account.ft_unapproved_record.should == record
    end
    
    it "onupdate: should remove ft_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      ft_customer_account = Factory(:ft_customer_account)
      ft_customer_account.reload
      ft_customer_account.ft_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      ft_customer_account.approval_status = 'A'
      ft_customer_account.save
      ft_customer_account.reload
      ft_customer_account.ft_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove ft_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      ft_customer_account = Factory(:ft_customer_account)
      ft_customer_account.reload
      ft_customer_account.ft_unapproved_record.should_not be_nil
      record = ft_customer_account.ft_unapproved_record
      # the approval process destroys the U record, for an edited record 
      ft_customer_account.destroy
      FtUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      ft_customer_account = Factory(:ft_customer_account, :approval_status => 'U')
      ft_customer_account.approve.should == ""
      ft_customer_account.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      ft_customer_account = Factory(:ft_customer_account, :approval_status => 'A')
      ft_customer_account1 = Factory(:ft_customer_account, :approval_status => 'U', :approved_id => ft_customer_account.id, :approved_version => 6)
      ft_customer_account1.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      ft_customer_account1 = Factory(:ft_customer_account, :approval_status => 'A')
      ft_customer_account2 = Factory(:ft_customer_account, :approval_status => 'U')
      ft_customer_account1.enable_approve_button?.should == false
      ft_customer_account2.enable_approve_button?.should == true
    end
  end
end
