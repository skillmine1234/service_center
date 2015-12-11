require 'spec_helper'

describe FpAuthRule do
  context "associations" do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end
  
  context "validations" do
    [:username, :operation_name].each do |att|
      it { should validate_presence_of(att)}
    end
    
    it do
      fp_auth_rule = Factory(:fp_auth_rule, :operation_name => 'App10', :approval_status => 'A')
      should validate_uniqueness_of(:operation_name).scoped_to(:approval_status, :username)
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      fp_auth_rule1 = Factory(:fp_auth_rule, :approval_status => 'A') 
      fp_auth_rule2 = Factory(:fp_auth_rule, :operation_name => "qweas")
      FpAuthRule.all.should == [fp_auth_rule1]
      fp_auth_rule2.approval_status = 'A'
      fp_auth_rule2.save
      FpAuthRule.all.should == [fp_auth_rule1,fp_auth_rule2]
    end
  end    

  context "fp_unapproved_records" do 
    it "oncreate: should create fp_unapproved_record if the approval_status is 'U'" do
      fp_auth_rule = Factory(:fp_auth_rule)
      fp_auth_rule.reload
      fp_auth_rule.fp_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create fp_unapproved_record if the approval_status is 'A'" do
      fp_auth_rule = Factory(:fp_auth_rule, :approval_status => 'A')
      fp_auth_rule.fp_unapproved_record.should be_nil
    end

    it "onupdate: should not remove fp_unapproved_record if approval_status did not change from U to A" do
      fp_auth_rule = Factory(:fp_auth_rule)
      fp_auth_rule.reload
      fp_auth_rule.fp_unapproved_record.should_not be_nil
      record = fp_auth_rule.fp_unapproved_record
      # we are editing the U record, before it is approved
      fp_auth_rule.operation_name = 'Fooo'
      fp_auth_rule.save
      fp_auth_rule.reload
      fp_auth_rule.fp_unapproved_record.should == record
    end
    
    it "onupdate: should remove fp_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      fp_auth_rule = Factory(:fp_auth_rule)
      fp_auth_rule.reload
      fp_auth_rule.fp_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      fp_auth_rule.approval_status = 'A'
      fp_auth_rule.save
      fp_auth_rule.reload
      fp_auth_rule.fp_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove fp_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      fp_auth_rule = Factory(:fp_auth_rule)
      fp_auth_rule.reload
      fp_auth_rule.fp_unapproved_record.should_not be_nil
      record = fp_auth_rule.fp_unapproved_record
      # the approval process destroys the U record, for an edited record 
      fp_auth_rule.destroy
      FpUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      fp_auth_rule = Factory(:fp_auth_rule, :approval_status => 'U')
      fp_auth_rule.approve.should == ""
      fp_auth_rule.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      fp_auth_rule = Factory(:fp_auth_rule, :approval_status => 'A')
      fp_auth_rule2 = Factory.build(:fp_auth_rule, :approval_status => 'U', :approved_id => fp_auth_rule.id, :approved_version => 6)
      fp_auth_rule2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      fp_auth_rule1 = Factory(:fp_auth_rule, :approval_status => 'A')
      fp_auth_rule2 = Factory(:fp_auth_rule, :operation_name => "qweas", :approval_status => 'U')
      fp_auth_rule1.enable_approve_button?.should == false
      fp_auth_rule2.enable_approve_button?.should == true
    end
  end
end
