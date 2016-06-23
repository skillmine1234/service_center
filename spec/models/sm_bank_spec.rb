require 'spec_helper'

describe SmBank do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:sm_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end
  
  context 'validation' do
    [:code, :name, :bank_code, :low_balance_alert_at, :identity_user_id, :neft_allowed, :imps_allowed].each do |att|
      it { should validate_presence_of(att) }
    end

    it do
      sm_bank = Factory(:sm_bank, :approval_status => 'A')

      [:code, :identity_user_id].each do |att|
        should validate_length_of(att).is_at_most(20)
      end

      should validate_length_of(:name).is_at_most(100)
    end

    it {should validate_numericality_of(:low_balance_alert_at)}

    it do 
      sm_bank = Factory(:sm_bank, :approval_status => 'A')
      should validate_uniqueness_of(:code).scoped_to(:approval_status)
    end

    it "should return error if code is already taken" do
      sm_bank1 = Factory(:sm_bank, :code => "9001", :approval_status => 'A')
      sm_bank2 = Factory.build(:sm_bank, :code => "9001", :approval_status => 'A')
      sm_bank2.should_not be_valid
      sm_bank2.errors_on(:code).should == ["has already been taken"]
    end

    it "should return error when low_balance_alert_at < 0" do
      sm_bank = Factory.build(:sm_bank, :low_balance_alert_at => -10)
      sm_bank.should_not be_valid
      sm_bank.errors_on(:low_balance_alert_at).should == ["must be greater than 0"]
    end
  end

  context "fields format" do
    it "should allow valid format" do
      [:code, :identity_user_id].each do |att|
        should allow_value('9876').for(att)
        should allow_value('ABCD90').for(att)
        should allow_value('abcd1234E').for(att)
      end

      should allow_value('ABCDCo').for(:name)
      should allow_value('ABCD Co').for(:name)

      should allow_value('ABCD0123456').for(:bank_code)
    end

    it "should not allow invalid format" do
      sm_bank = Factory.build(:sm_bank, :code => "BANK-01", :name => "abcd-QWER", :bank_code => "@Bank01", :identity_user_id => "IUID-1")
      sm_bank.save.should be_false
      [:code, :identity_user_id].each do |att|
        sm_bank.errors_on(att).should == ["Invalid format, expected format is : {[a-z|A-Z|0-9]}"]
      end
      sm_bank.errors_on(:name).should ==  ["Invalid format, expected format is : {[a-z|A-Z|0-9\\s]}"]
      sm_bank.errors_on(:bank_code).should ==  ["invalid format - expected format is : {[A-Z|a-z]{4}[0][A-Za-z0-9]{6}}"]
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      sm_bank1 = Factory(:sm_bank, :approval_status => 'A') 
      sm_bank2 = Factory(:sm_bank, :code => '1234567891')
      SmBank.all.should == [sm_bank1]
      sm_bank2.approval_status = 'A'
      sm_bank2.save
      SmBank.all.should == [sm_bank1,sm_bank2]
    end
  end    

  context "sm_unapproved_records" do 
    it "oncreate: should create sm_unapproved_record if the approval_status is 'U'" do
      sm_bank = Factory(:sm_bank)
      sm_bank.reload
      sm_bank.sm_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create sm_unapproved_record if the approval_status is 'A'" do
      sm_bank = Factory(:sm_bank, :approval_status => 'A')
      sm_bank.sm_unapproved_record.should be_nil
    end

    it "onupdate: should not remove sm_unapproved_record if approval_status did not change from U to A" do
      sm_bank = Factory(:sm_bank)
      sm_bank.reload
      sm_bank.sm_unapproved_record.should_not be_nil
      record = sm_bank.sm_unapproved_record
      # we are editing the U record, before it is approved
      sm_bank.name = 'Foo edited'
      sm_bank.save
      sm_bank.reload
      sm_bank.sm_unapproved_record.should == record
    end
    
    it "onupdate: should remove sm_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      sm_bank = Factory(:sm_bank)
      sm_bank.reload
      sm_bank.sm_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      sm_bank.approval_status = 'A'
      sm_bank.save
      sm_bank.reload
      sm_bank.sm_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove sm_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      sm_bank = Factory(:sm_bank)
      sm_bank.reload
      sm_bank.sm_unapproved_record.should_not be_nil
      record = sm_bank.sm_unapproved_record
      # the approval process destroys the U record, for an edited record 
      sm_bank.destroy
      SmUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      sm_bank = Factory(:sm_bank, :approval_status => 'U')
      sm_bank.approve.should == ""
      sm_bank.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      sm_bank = Factory(:sm_bank, :approval_status => 'A')
      sm_bank1 = Factory(:sm_bank, :approval_status => 'U', :approved_id => sm_bank.id, :approved_version => 6)
      sm_bank1.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      sm_bank1 = Factory(:sm_bank, :approval_status => 'A')
      sm_bank2 = Factory(:sm_bank, :approval_status => 'U')
      sm_bank1.enable_approve_button?.should == false
      sm_bank2.enable_approve_button?.should == true
    end
  end
end