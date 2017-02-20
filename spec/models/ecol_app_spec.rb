require 'spec_helper'

describe EcolApp do
  context "associations" do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end
  
  context "encrypt_password" do 
    it "should encrypt the http_password" do 
      ecol_app = Factory.build(:ecol_app, http_username: 'username', http_password: 'password')
      ecol_app.save.should be_true
      ecol_app.reload
      ecol_app.http_password.should == "password"
    end
  end
  
  context "decrypt_password" do 
    it "should decrypt the http_password" do 
      ecol_app = Factory(:ecol_app, http_username: 'username', http_password: 'password')
      ecol_app.http_password.should == "password"
    end
  end

  context "validation" do
    [:app_code].each do |att|
      it { should validate_presence_of(att) }
    end
    it "should validate presence of http_password if http_username is present" do
      ecol_app = Factory.build(:ecol_app, http_username: 'username', http_password: nil)
      ecol_app.save.should == false
      ecol_app.errors[:base].should == ["HTTP Password can't be blank if HTTP Username is present"]
    end
  end

  context "ecol_unapproved_records" do 
    it "onupdate: should not remove ecol_unapproved_record if approval_status did not change from U to A" do
      ecol_app = Factory(:ecol_app)
      ecol_app.reload
      ecol_app.ecol_unapproved_record.should_not be_nil
      record = ecol_app.ecol_unapproved_record
      # we are editing the U record, before it is approved
      ecol_app.notify_url = 'http://localhost'
      ecol_app.save
      ecol_app.reload
      ecol_app.ecol_unapproved_record.should == record
    end
    
    it "onupdate: should remove ecol_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      ecol_app = Factory(:ecol_app)
      ecol_app.reload
      ecol_app.ecol_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      ecol_app.approval_status = 'A'
      ecol_app.save
      ecol_app.reload
      ecol_app.ecol_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove sm_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      ecol_app = Factory(:ecol_app)
      ecol_app.reload
      ecol_app.ecol_unapproved_record.should_not be_nil
      record = ecol_app.ecol_unapproved_record
      # the approval process destroys the U record, for an edited record 
      ecol_app.destroy
      EcolUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      ecol_app = Factory(:ecol_app, :approval_status => 'U')
      ecol_app.approve.should == ""
      ecol_app.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      ecol_app = Factory(:ecol_app, :approval_status => 'A')
      ecol_app1 = Factory(:ecol_app, :approval_status => 'U', :approved_id => ecol_app.id, :approved_version => 6)
      ecol_app1.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      ecol_app1 = Factory(:ecol_app, :approval_status => 'A')
      ecol_app2 = Factory(:ecol_app, :approval_status => 'U')
      ecol_app1.enable_approve_button?.should == false
      ecol_app2.enable_approve_button?.should == true
    end
  end
  
  context "set_settings_cnt" do
    it "should set counts of settings" do
      ecol_app = Factory(:ecol_app, setting1_name: 'set1', setting1_type: 'number', setting1_value: 1)
      ecol_app.settings_cnt.should == 1
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      ecol_app1 = Factory(:ecol_app, :approval_status => 'A') 
      ecol_app2 = Factory(:ecol_app, :notify_url => 'http://localhost')
      EcolApp.all.should == [ecol_app1]
      ecol_app2.approval_status = 'A'
      ecol_app2.save
      EcolApp.all.should == [ecol_app1,ecol_app2]
    end
  end
end
