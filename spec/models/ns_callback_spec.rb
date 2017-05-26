require 'spec_helper'

describe NsCallback do
  context "associations" do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end
  
  context "encrypt_password" do 
    it "should encrypt the http_password" do 
      ns_callback = Factory.build(:ns_callback, http_username: 'username', http_password: 'password')
      ns_callback.save.should be_true
      ns_callback.reload
      ns_callback.http_password.should == "password"
    end
  end
  
  context "decrypt_password" do 
    it "should decrypt the http_password" do 
      ns_callback = Factory(:ns_callback, http_username: 'username', http_password: 'password')
      ns_callback.http_password.should == "password"
    end
  end

  context "validation" do
    [:app_code].each do |att|
      it { should validate_presence_of(att) }
    end
    it "should validate presence of http_password if http_username is present" do
      ns_callback = Factory.build(:ns_callback, http_username: 'username', http_password: nil)
      ns_callback.save.should == false
      ns_callback.errors[:base].should == ["HTTP Password can't be blank if HTTP Username is present"]
    end
    
    it "should validate length of fields" do 
      should validate_length_of(:app_code).is_at_most(50)
      should validate_length_of(:http_username).is_at_most(50)
      should validate_length_of(:http_password).is_at_most(50)
      should validate_length_of(:notify_url).is_at_most(100)
    end
    
    it "should not allow to set value udf2 if udf1 is not present" do
      ns_callback = Factory.build(:ns_callback, udf1_name: nil, udf1_type: nil, udf2_name: 'udf2', udf2_type: 'text')
      ns_callback.errors_on(:udf1_name).should == ["can't be blank when Udf2 name is present"]
    end
    it "should not allow to set value udf3 if udf2 is not present" do
      ns_callback = Factory.build(:ns_callback, udf1_name: 'udf1', udf1_type: 'text', udf2_name: nil, udf2_type: nil, udf3_name: 'udf2', udf3_type: 'text')
      ns_callback.errors_on(:udf2_name).should == ["can't be blank when Udf3 name is present"]
    end
    it "should not allow to set value udf4 if udf3 is not present" do
      ns_callback = Factory.build(:ns_callback, udf1_name: 'udf1', udf1_type: 'text', udf2_name: 'udf2', udf2_type: 'text', udf3_name: nil, udf3_type: nil, udf4_name: 'udf2', udf4_type: 'text')
      ns_callback.errors_on(:udf3_name).should == ["can't be blank when Udf4 name is present"]
    end
    it "should not allow to set value udf5 if udf4 is not present" do
      ns_callback = Factory.build(:ns_callback, udf1_name: 'udf1', udf1_type: 'text', udf2_name: 'udf2', udf2_type: 'text', udf3_name: 'udf2', udf3_type: 'text', udf4_name: nil, udf4_type: nil, udf5_name: 'udf2', udf5_type: 'text')
      ns_callback.errors_on(:udf4_name).should == ["can't be blank when Udf5 name is present"]
    end
  end

  context "unapproved_record_entrys" do 
    it "onupdate: should not remove unapproved_record_entry if approval_status did not change from U to A" do
      ns_callback = Factory(:ns_callback)
      ns_callback.reload
      ns_callback.unapproved_record_entry.should_not be_nil
      record = ns_callback.unapproved_record_entry
      # we are editing the U record, before it is approved
      ns_callback.notify_url = 'http://localhost'
      ns_callback.save
      ns_callback.reload
      ns_callback.unapproved_record_entry.should == record
    end
    
    it "onupdate: should remove unapproved_record_entry if the approval_status changed from 'U' to 'A' (approval)" do
      ns_callback = Factory(:ns_callback)
      ns_callback.reload
      ns_callback.unapproved_record_entry.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      ns_callback.approval_status = 'A'
      ns_callback.save
      ns_callback.reload
      ns_callback.unapproved_record_entry.should be_nil
    end
    
    it "ondestroy: should remove sm_unapproved_record_entry if the record with approval_status 'U' was destroyed (approval) " do
      ns_callback = Factory(:ns_callback)
      ns_callback.reload
      ns_callback.unapproved_record_entry.should_not be_nil
      record = ns_callback.unapproved_record_entry
      # the approval process destroys the U record, for an edited record 
      ns_callback.destroy
      UnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record_entry" do 
      ns_callback = Factory(:ns_callback, :approval_status => 'U')
      ns_callback.approve.save.should == true
      ns_callback.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      ns_callback = Factory(:ns_callback, :approval_status => 'A')
      ns_callback1 = Factory(:ns_callback, :approval_status => 'U', :approved_id => ns_callback.id, :approved_version => 6)
      ns_callback1.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      ns_callback1 = Factory(:ns_callback, :approval_status => 'A')
      ns_callback2 = Factory(:ns_callback, :approval_status => 'U')
      ns_callback1.enable_approve_button?.should == false
      ns_callback2.enable_approve_button?.should == true
    end
  end
  
  context "set_settings_cnt" do
    it "should set counts of settings" do
      ns_callback = Factory(:ns_callback, setting1_name: 'set1', setting1_type: 'number', setting1_value: 1)
      ns_callback.settings_cnt.should == 1
    end
  end
  
  context "set_udfs_cnt" do
    it "should set counts of udfs" do
      ns_callback = Factory(:ns_callback, udf1_name: 'set1', udf1_type: 'number')
      ns_callback.udfs_cnt.should == 1
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      ns_callback1 = Factory(:ns_callback, :approval_status => 'A') 
      ns_callback2 = Factory(:ns_callback, :notify_url => 'http://localhost')
      NsCallback.all.should == [ns_callback1]
      ns_callback2.approval_status = 'A'
      ns_callback2.save
      NsCallback.all.should == [ns_callback1,ns_callback2]
    end
  end
end
