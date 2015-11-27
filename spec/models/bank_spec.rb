require 'spec_helper'

describe Bank do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:inw_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end

  context 'validation' do
    [:ifsc, :name].each do |att|
      it { should validate_presence_of(att) }
    end

    # it {should validate_inclusion_of(:imps_enabled).in_array([true,false]) }
    it do
      bank = Factory(:bank)
      should validate_uniqueness_of(:ifsc).scoped_to(:approval_status)
    end

    context "ifsc format" do 
      it "should validate the format of ifsc" do 
        bank = Factory.build(:bank, :ifsc => 'ABcd0dsg34A')
        bank.should be_valid
        bank = Factory.build(:bank, :ifsc => 'ABcd0dsg34')
        bank.should_not be_valid
        bank = Factory.build(:bank, :ifsc => 'ABcd4dsg34A')
        bank.should_not be_valid
        bank = Factory.build(:bank, :ifsc => 'ABcd0dsg34$')
        bank.should_not be_valid
        bank = Factory.build(:bank, :ifsc => 'ABc@0dsg34A')
        bank.should_not be_valid
        bank = Factory.build(:bank, :ifsc => 'ABc@@dsg34A')
        bank.should_not be_valid
      end
    end

    context "name format" do
      it "should allow valid format" do 
        [:name].each do |att|
          should allow_value('abcddfgdfg').for(att)
          should allow_value('aBCDdfdsgs').for(att)
        end
      end

      it "should not allow invalid format" do 
        [:name].each do |att|
          should_not allow_value('ab*dsgdsgf').for(att)
          should_not allow_value('a12232424V').for(att)
          should_not allow_value('@acddsfdfd').for(att)
          should_not allow_value('134\ndsfdsg').for(att)
        end
      end
    end

    context "imps_enabled?" do 
      it "should return 'Y' if imps_enabled is true and 'N' if false" do 
        bank = Factory(:bank, :imps_enabled => 1)
        bank.imps_enabled?.should == 'Y'
        bank = Factory(:bank, :imps_enabled => 0)
        bank.imps_enabled?.should == 'N'
      end
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      bank1 = Factory(:bank, :approval_status => 'A') 
      bank2 = Factory(:bank)
      Bank.all.should == [bank1]
      bank2.approval_status = 'A'
      bank2.save
      Bank.all.should == [bank1,bank2]
    end
  end    

  context "create_inw_unapproved_records" do 
    it "should create inw_unapproved_record if the approval_status is 'U' and there is no previous record" do
      bank = Factory(:bank)
      bank.reload
      bank.inw_unapproved_record.should_not be_nil
      record = bank.inw_unapproved_record
      bank.name = 'Fooo'
      bank.save
      bank.inw_unapproved_record.should == record
    end

    it "should not create inw_unapproved_record if the approval_status is 'A'" do
      bank = Factory(:bank, :approval_status => 'A')
      bank.inw_unapproved_record.should be_nil
    end
  end  

  # context "remove_inw_unapproved_records" do
  #   it "should remove inw_unapproved_record if the approval_status is 'A' and there is unapproved_record" do
  #     bank = Factory(:bank)
  #     bank.reload
  #     bank.inw_unapproved_record.should_not be_nil
  #     record = bank.inw_unapproved_record
  #     bank.name = 'Foo'
  #     bank.save
  #     bank.inw_unapproved_record.should == record
  #     bank.approval_status = 'A'
  #     bank.save
  #     bank.remove_inw_unapproved_records
  #     bank.reload
  #     bank.inw_unapproved_record.should be_nil
  #   end
  # end

  context "approve" do 
    it "should approve unapproved_record" do 
      bank = Factory(:bank, :approval_status => 'U')
      bank.approve.should == ""
      bank.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      bank = Factory(:bank, :approval_status => 'A')
      bank2 = Factory(:bank, :approval_status => 'U', :approved_id => bank.id, :approved_version => 6)
      bank2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      bank1 = Factory(:bank, :approval_status => 'A')
      bank2 = Factory(:bank, :approval_status => 'U')
      bank1.enable_approve_button?.should == false
      bank2.enable_approve_button?.should == true
    end
  end
  
end