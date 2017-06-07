require 'spec_helper'

describe NsTemplate do
  context "associations" do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should belong_to(:sc_event) }
  end

  context "validation" do
    [:sc_event_id].each do |att|
      it { should validate_presence_of(att) }
    end

    it do
      should validate_uniqueness_of(:sc_event_id).scoped_to(:approval_status)
    end
    
    it "should validate presence of sms_text or email_body" do
      ns_template = Factory.build(:ns_template, sms_text: nil, email_body: nil)
      ns_template.save.should == false
      ns_template.errors[:base].should == ["Either SMS or Email should be present"]
    end

    it "should validate presence of email_subject if email_body is present" do
      ns_template = Factory.build(:ns_template, sms_text: nil, email_subject: nil, email_body: 'Hi')
      ns_template.save.should == false
      ns_template.errors[:email_subject].should == ["should be present when email body is not emmpty"]
    end

    it "should validate presence of email_body if email_subject is present" do
      ns_template = Factory.build(:ns_template, sms_text: nil, email_subject: 'Hi', email_body: nil)
      ns_template.save.should == false
      ns_template.errors[:email_body].should == ["should be present when email subject is not empty"]
    end

    context "validate_template" do 
      it "should validate sms_text template" do
        topic = Factory.build(:ns_template, :sms_text => "Hi {{name}")
        topic.should_not be_valid
        topic.errors_on(:sms_text).count.should == 1
        topic.sms_text = "Hi {{name}}"
        topic.should be_valid
      end

      it "should validate email_text template" do
        topic = Factory.build(:ns_template, :email_subject => 'subject', :email_body => "Hi {{name}")
        topic.should_not be_valid
        topic.errors_on(:email_body).count.should == 1
        topic.email_body = "Hi {{name}}"
        topic.should be_valid
      end
    end
  end

  context "unapproved_record_entrys" do 
    it "onupdate: should not remove unapproved_record_entry if approval_status did not change from U to A" do
      ns_template = Factory(:ns_template)
      ns_template.reload
      ns_template.unapproved_record_entry.should_not be_nil
      record = ns_template.unapproved_record_entry
      # we are editing the U record, before it is approved
      ns_template.sms_text = 'template'
      ns_template.save
      ns_template.reload
      ns_template.unapproved_record_entry.should == record
    end
    
    it "onupdate: should remove unapproved_record_entry if the approval_status changed from 'U' to 'A' (approval)" do
      ns_template = Factory(:ns_template)
      ns_template.reload
      ns_template.unapproved_record_entry.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      ns_template.approval_status = 'A'
      ns_template.save
      ns_template.reload
      ns_template.unapproved_record_entry.should be_nil
    end
    
    it "ondestroy: should remove sm_unapproved_record_entry if the record with approval_status 'U' was destroyed (approval) " do
      ns_template = Factory(:ns_template)
      ns_template.reload
      ns_template.unapproved_record_entry.should_not be_nil
      record = ns_template.unapproved_record_entry
      # the approval process destroys the U record, for an edited record 
      ns_template.destroy
      UnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record_entry" do 
      ns_template = Factory(:ns_template, :approval_status => 'U')
      ns_template.approve.save.should == true
      ns_template.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      ns_template = Factory(:ns_template, :approval_status => 'A')
      ns_template1 = Factory(:ns_template, :approval_status => 'U', :approved_id => ns_template.id, :approved_version => 6)
      ns_template1.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      ns_template1 = Factory(:ns_template, :approval_status => 'A')
      ns_template2 = Factory(:ns_template, :approval_status => 'U')
      ns_template1.enable_approve_button?.should == false
      ns_template2.enable_approve_button?.should == true
    end
  end
  
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      ns_template1 = Factory(:ns_template, :approval_status => 'A') 
      ns_template2 = Factory(:ns_template, :sms_text => 'template')
      NsTemplate.all.should == [ns_template1]
      ns_template2.approval_status = 'A'
      ns_template2.save
      NsTemplate.all.should == [ns_template1,ns_template2]
    end
  end
end
