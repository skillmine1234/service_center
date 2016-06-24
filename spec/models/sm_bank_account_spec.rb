require 'spec_helper'

describe SmBankAccount do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:sm_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end
  
  context 'validation' do
    [:sm_code, :customer_id, :account_no, :mmid, :mobile_no].each do |att|
      it { should validate_presence_of(att) }
    end

    it do 
      sm_bank_account = Factory(:sm_bank_account, :approval_status => 'A')
      should validate_uniqueness_of(:sm_code).scoped_to(:customer_id, :account_no, :approval_status)

      should validate_length_of(:sm_code).is_at_most(20) 
      should validate_length_of(:customer_id).is_at_least(3).is_at_most(15)
      should validate_length_of(:account_no).is_at_least(1).is_at_most(15)
      should validate_length_of(:mmid).is_at_least(7).is_at_most(7)
      should validate_length_of(:mobile_no).is_at_least(10).is_at_most(10)
    end

    [:customer_id, :mmid, :mobile_no].each do |att|
      it { should validate_numericality_of(att) }
    end

    it "should return error if sm_code is already taken" do
      sm_bank_account1 = Factory(:sm_bank_account, :sm_code => "0999", :customer_id => "9999", :account_no => "6099999901", :approval_status => 'A')
      sm_bank_account2 = Factory.build(:sm_bank_account, :sm_code => "0999", :customer_id => "9999", :account_no => "6099999901", :approval_status => 'A')
      sm_bank_account2.should_not be_valid
      sm_bank_account2.errors_on(:sm_code).should == ["has already been taken"]
    end
  end

  context "fields format" do
    it "should allow valid format" do
      [:sm_code, :account_no].each do |att|
        should allow_value('9876').for(att)
        should allow_value('ABCD90').for(att)
        should allow_value('abcd1234E').for(att)
      end

      should allow_value('123').for(:customer_id)
      should allow_value('123456789098765').for(:customer_id)

      should allow_value('1234567').for(:mmid)

      should allow_value('9087654321').for(:mobile_no)
    end

    it "should not allow invalid format" do
      sm_bank_account = Factory.build(:sm_bank_account, :sm_code => "BANK_ACC_01", :customer_id => "CUST01", :account_no => "ACC-01", :mmid => "MMID-01", :mobile_no => "+918888665")
      sm_bank_account.save.should be_false
      [:sm_code, :account_no].each do |att|
        sm_bank_account.errors_on(att).should == ["Invalid format, expected format is : {[a-z|A-Z|0-9]}"]
      end
      sm_bank_account.errors_on(:customer_id).should == ["is not a number", "Invalid format, expected format is : {[0-9]}"]
      sm_bank_account.errors_on(:mmid).should == ["is not a number"]
      sm_bank_account.errors_on(:mobile_no).should == ["Invalid format, expected format is : {[0-9]}"]
    end
  end

  context "to_downcase" do 
    it "should convert the sm_code, account_no to lower case" do 
      sm_bank_account = Factory.build(:sm_bank_account, :sm_code => "BANKACCCODE01", :account_no => "BANKACC01")
      sm_bank_account.to_downcase
      sm_bank_account.sm_code.should == "bankacccode01"
      sm_bank_account.account_no.should == "bankacc01"
      sm_bank_account.save.should be_true
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      sm_bank_account1 = Factory(:sm_bank_account, :approval_status => 'A') 
      sm_bank_account2 = Factory(:sm_bank_account, :sm_code => '1234567891')
      SmBankAccount.all.should == [sm_bank_account1]
      sm_bank_account2.approval_status = 'A'
      sm_bank_account2.save
      SmBankAccount.all.should == [sm_bank_account1,sm_bank_account2]
    end
  end    

  context "sm_unapproved_records" do 
    it "oncreate: should create sm_unapproved_record if the approval_status is 'U'" do
      sm_bank_account = Factory(:sm_bank_account)
      sm_bank_account.reload
      sm_bank_account.sm_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create sm_unapproved_record if the approval_status is 'A'" do
      sm_bank_account = Factory(:sm_bank_account, :approval_status => 'A')
      sm_bank_account.sm_unapproved_record.should be_nil
    end

    it "onupdate: should not remove sm_unapproved_record if approval_status did not change from U to A" do
      sm_bank_account = Factory(:sm_bank_account)
      sm_bank_account.reload
      sm_bank_account.sm_unapproved_record.should_not be_nil
      record = sm_bank_account.sm_unapproved_record
      # we are editing the U record, before it is approved
      sm_bank_account.mobile_no = 1234567888
      sm_bank_account.save
      sm_bank_account.reload
      sm_bank_account.sm_unapproved_record.should == record
    end
    
    it "onupdate: should remove sm_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      sm_bank_account = Factory(:sm_bank_account)
      sm_bank_account.reload
      sm_bank_account.sm_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      sm_bank_account.approval_status = 'A'
      sm_bank_account.save
      sm_bank_account.reload
      sm_bank_account.sm_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove sm_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      sm_bank_account = Factory(:sm_bank_account)
      sm_bank_account.reload
      sm_bank_account.sm_unapproved_record.should_not be_nil
      record = sm_bank_account.sm_unapproved_record
      # the approval process destroys the U record, for an edited record 
      sm_bank_account.destroy
      SmUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      sm_bank_account = Factory(:sm_bank_account, :approval_status => 'U')
      sm_bank_account.approve.should == ""
      sm_bank_account.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      sm_bank_account = Factory(:sm_bank_account, :approval_status => 'A')
      sm_bank_account1 = Factory(:sm_bank_account, :approval_status => 'U', :approved_id => sm_bank_account.id, :approved_version => 6)
      sm_bank_account1.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      sm_bank_account1 = Factory(:sm_bank_account, :approval_status => 'A')
      sm_bank_account2 = Factory(:sm_bank_account, :approval_status => 'U')
      sm_bank_account1.enable_approve_button?.should == false
      sm_bank_account2.enable_approve_button?.should == true
    end
  end
end