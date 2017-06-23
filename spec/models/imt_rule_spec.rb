require 'spec_helper'

describe ImtRule do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:imt_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end

  context 'validation' do
    [:stl_gl_account, :chargeback_gl_account, :lock_version, :approval_status].each do |att|
      it { should validate_presence_of(att) }
    end

    it do
      imt_rule = Factory(:imt_rule)
      should validate_length_of(:stl_gl_account).is_at_most(16)
      should validate_length_of(:chargeback_gl_account).is_at_most(16)
    end

    it "should validate_unapproved_record" do
      imt_rule1 = Factory(:imt_rule,:approval_status => 'A')
      imt_rule2 = Factory(:imt_rule, :approved_id => imt_rule1.id)
      imt_rule1.should_not be_valid
      imt_rule1.errors_on(:base).should == ["Unapproved Record Already Exists for this record"]
    end

    context "fields format" do
      it "should allow valid format" do
        [:stl_gl_account, :chargeback_gl_account].each do |att|
          should allow_value('987654310').for(att)
          should allow_value('8888000').for(att)
        end
      end

      it "should not allow invalid format" do
        imt_rule = Factory.build(:imt_rule, :stl_gl_account => 'AAABBBC090', :chargeback_gl_account => '@,.9023jsf')
        imt_rule.save == false
        [:stl_gl_account, :chargeback_gl_account].each do |att|
          imt_rule.errors_on(att).should == ["Invalid format, expected format is : {[0-9]}"]
        end
      end
    end
  end

  context "default_scope" do
    it "should only return 'A' records by default" do
      imt_rule1 = Factory(:imt_rule, :approval_status => 'A')
      imt_rule2 = Factory(:imt_rule)
      ImtRule.all.should == [imt_rule1]
      imt_rule2.approval_status = 'A'
      imt_rule2.save
      ImtRule.all.should == [imt_rule1, imt_rule2]
    end
  end

  context "imt_unapproved_records" do 
    it "oncreate: should create imt_unapproved_record if the approval_status is 'U'" do
      imt_rule = Factory(:imt_rule)
      imt_rule.reload
      imt_rule.imt_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create imt_unapproved_record if the approval_status is 'A'" do
      imt_rule = Factory(:imt_rule, :approval_status => 'A')
      imt_rule.imt_unapproved_record.should be_nil
    end

    it "onupdate: should not remove imt_unapproved_record if approval_status did not change from U to A" do
      imt_rule = Factory(:imt_rule)
      imt_rule.reload
      imt_rule.imt_unapproved_record.should_not be_nil
      record = imt_rule.imt_unapproved_record
      # we are editing the U record, before it is approved
      imt_rule.stl_gl_account = '0987654321'
      imt_rule.save
      imt_rule.reload
      imt_rule.imt_unapproved_record.should == record
    end
    
    it "onupdate: should remove imt_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      imt_rule = Factory(:imt_rule)
      imt_rule.reload
      imt_rule.imt_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      imt_rule.approval_status = 'A'
      imt_rule.save
      imt_rule.reload
      imt_rule.imt_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove imt_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      imt_rule = Factory(:imt_rule)
      imt_rule.reload
      imt_rule.imt_unapproved_record.should_not be_nil
      record = imt_rule.imt_unapproved_record
      # the approval process destroys the U record, for an edited record 
      imt_rule.destroy
      ImtUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do
    it "should approve unapproved_record" do
      imt_rule = Factory(:imt_rule, :approval_status => 'U')
      imt_rule.approve.should == ""
      imt_rule.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do
      imt_rule = Factory(:imt_rule, :approval_status => 'A')
      imt_rule2 = Factory(:imt_rule, :approval_status => 'U', :approved_id => imt_rule.id, :approved_version => 6)
      imt_rule2.approve.should == "The record version is different from that of the approved version"
    end
  end

  context "enable_approve_button?" do
    it "should return true if approval_status is 'U' else false" do
      imt_rule1 = Factory(:imt_rule, :approval_status => 'A')
      imt_rule2 = Factory(:imt_rule, :approval_status => 'U')
      imt_rule1.enable_approve_button?.should == false
      imt_rule2.enable_approve_button?.should == true
    end
  end
end
