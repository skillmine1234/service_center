require 'spec_helper'

describe Pc2App do  
  include HelperMethods
  
  before(:each) do
    mock_ldap
  end

  context "associations" do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:unapproved_record_entry) }    
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
    it { should have_many(:pc2_cust_accounts) }
  end
  
  context "validations" do
    [:app_id, :identity_user_id, :customer_id].each do |att|
      it { should validate_presence_of(att)}
    end
    
    it { should validate_numericality_of(:customer_id)}

    it do
      pc2_app = Factory(:pc2_app, :app_id => 'App10', :approval_status => 'A')
      should validate_uniqueness_of(:customer_id).scoped_to(:app_id, :approval_status)  
    end

    it "should validate length" do
      pc2_app = Factory(:pc2_app, :approval_status => 'A')
      should validate_length_of(:customer_id).is_at_most(15)
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      pc2_app1 = Factory(:pc2_app, :approval_status => 'A') 
      pc2_app2 = Factory(:pc2_app)
      Pc2App.all.should == [pc2_app1]
      pc2_app2.approval_status = 'A'
      pc2_app2.save
      Pc2App.all.should == [pc2_app1,pc2_app2]
    end
  end    

  context "unapproved_records" do 
    it "oncreate: should create unapproved_record_entry if the approval_status is 'U'" do
      pc2_app = Factory(:pc2_app)
      pc2_app.reload
      pc2_app.unapproved_record_entry.should_not be_nil
    end

    it "oncreate: should not create unapproved_record_entry if the approval_status is 'A'" do
      pc2_app = Factory(:pc2_app, :approval_status => 'A')
      pc2_app.unapproved_record_entry.should be_nil
    end

    it "onupdate: should not remove unapproved_record_entry if approval_status did not change from U to A" do
      pc2_app = Factory(:pc2_app)
      pc2_app.reload
      pc2_app.unapproved_record_entry.should_not be_nil
      record = pc2_app.unapproved_record_entry
      # we are editing the U record, before it is approved
      pc2_app.customer_id = 'Fooo'
      pc2_app.save
      pc2_app.reload
      pc2_app.unapproved_record_entry.should == record
    end
    
    it "onupdate: should remove unapproved_record_entry if the approval_status changed from 'U' to 'A' (approval)" do
      pc2_app = Factory(:pc2_app)
      pc2_app.reload
      pc2_app.unapproved_record_entry.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      pc2_app.approval_status = 'A'
      pc2_app.save
      pc2_app.reload
      pc2_app.unapproved_record_entry.should be_nil
    end
    
    it "ondestroy: should remove unapproved_record_entry if the record with approval_status 'U' was destroyed (approval) " do
      pc2_app = Factory(:pc2_app)
      pc2_app.reload
      pc2_app.unapproved_record_entry.should_not be_nil
      record = pc2_app.unapproved_record_entry
      # the approval process destroys the U record, for an edited record 
      pc2_app.destroy
      UnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      pc2_app = Factory(:pc2_app, :approval_status => 'U')
      pc2_app.approve.save.should == true
      pc2_app.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      pc2_app = Factory(:pc2_app, :approval_status => 'A')
      pc2_app2 = Factory(:pc2_app, :approval_status => 'U', :approved_id => pc2_app.id, :approved_version => 6)
      pc2_app2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      pc2_app1 = Factory(:pc2_app, :approval_status => 'A')
      pc2_app2 = Factory(:pc2_app, :approval_status => 'U')
      pc2_app1.enable_approve_button?.should == false
      pc2_app2.enable_approve_button?.should == true
    end
  end
  
  # context "presence_of_iam_cust_user" do
  #   it "should validate existence of iam_cust_user" do
  #     pc_app = Factory.build(:pc_app, identity_user_id: '1234')
  #     pc_app.errors_on(:identity_user_id).should == ['IAM Customer User does not exist for this username']
  #
  #     iam_cust_user = Factory(:iam_cust_user, username: '1234', approval_status: 'A')
  #     pc_app.errors_on(:identity_user_id).should == []
  #   end
  # end
end