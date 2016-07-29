require 'spec_helper'

describe PcApp do
  context "associations" do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should belong_to(:pc_program) }
  end
  
  context "validations" do
    [:pc_program_id, :card_acct, :sc_gl_income, :card_cust_id, :traceid_prefix, :source_id, :channel_id].each do |att|
      it { should validate_presence_of(att)}
    end
    
    it do
      pc_app = Factory(:pc_app, :app_id => 'App10', :approval_status => 'A')
      should validate_uniqueness_of(:app_id).scoped_to(:approval_status)
    end
  end
  
  context "account no format" do 
    [:card_acct, :sc_gl_income, :card_cust_id].each do |att|
      it "should allow valid format" do
        should allow_value('1234567890').for(att)
        should allow_value('Abcd1234567890').for(att)
      end

      it "should not allow invalid format" do
        should_not allow_value('Absdjhsd&&').for(att)
        should_not allow_value('@AbcCo').for(att)
        should_not allow_value('/ab0QWER').for(att)
      end
    end 
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      pc_app1 = Factory(:pc_app, :approval_status => 'A') 
      pc_app2 = Factory(:pc_app)
      PcApp.all.should == [pc_app1]
      pc_app2.approval_status = 'A'
      pc_app2.save
      PcApp.all.should == [pc_app1,pc_app2]
    end
  end    

  context "pc_unapproved_records" do 
    it "oncreate: should create pc_unapproved_record if the approval_status is 'U'" do
      pc_app = Factory(:pc_app)
      pc_app.reload
      pc_app.pc_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create pc_unapproved_record if the approval_status is 'A'" do
      pc_app = Factory(:pc_app, :approval_status => 'A')
      pc_app.pc_unapproved_record.should be_nil
    end

    it "onupdate: should not remove pc_unapproved_record if approval_status did not change from U to A" do
      pc_app = Factory(:pc_app)
      pc_app.reload
      pc_app.pc_unapproved_record.should_not be_nil
      record = pc_app.pc_unapproved_record
      # we are editing the U record, before it is approved
      pc_app.card_acct = 'Fooo'
      pc_app.save
      pc_app.reload
      pc_app.pc_unapproved_record.should == record
    end
    
    it "onupdate: should remove pc_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      pc_app = Factory(:pc_app)
      pc_app.reload
      pc_app.pc_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      pc_app.approval_status = 'A'
      pc_app.save
      pc_app.reload
      pc_app.pc_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove pc_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      pc_app = Factory(:pc_app)
      pc_app.reload
      pc_app.pc_unapproved_record.should_not be_nil
      record = pc_app.pc_unapproved_record
      # the approval process destroys the U record, for an edited record 
      pc_app.destroy
      PcUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      pc_app = Factory(:pc_app, :approval_status => 'U')
      pc_app.approve.should == ""
      pc_app.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      pc_app = Factory(:pc_app, :approval_status => 'A')
      pc_app2 = Factory(:pc_app, :approval_status => 'U', :approved_id => pc_app.id, :approved_version => 6)
      pc_app2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      pc_app1 = Factory(:pc_app, :approval_status => 'A')
      pc_app2 = Factory(:pc_app, :approval_status => 'U')
      pc_app1.enable_approve_button?.should == false
      pc_app2.enable_approve_button?.should == true
    end
  end
end
