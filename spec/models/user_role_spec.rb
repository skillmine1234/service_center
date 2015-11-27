require 'spec_helper'

describe UserRole do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:inw_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end

  context 'validation' do
    [:user_id, :role_id].each do |att|
      it { should validate_presence_of(att) }
    end

    it do
      user_role = Factory(:user_role)
      should validate_uniqueness_of(:user_id).scoped_to(:approval_status)
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      user_role1 = Factory(:user_role, :user_id => 2, :approval_status => 'A') 
      user_role2 = Factory(:user_role, :approval_status => 'U')
      UserRole.all.should == [user_role1]
      user_role2.approval_status = 'A'
      user_role2.save
      UserRole.all.should == [user_role1,user_role2]
    end
  end    

  context "create_inw_unapproved_records" do 
    it "should create inw_unapproved_record if the approval_status is 'U' and there is no previous record" do
      user_role = Factory(:user_role, :approval_status => 'U')
      user_role.reload
      user_role.inw_unapproved_record.should_not be_nil
      record = user_role.inw_unapproved_record
      user_role.user_id = 8
      user_role.save
      user_role.inw_unapproved_record.should == record
    end

    it "should not create inw_unapproved_record if the approval_status is 'A'" do
      user_role = Factory(:user_role, :approval_status => 'A')
      user_role.inw_unapproved_record.should be_nil
    end
  end  

  # context "remove_inw_unapproved_records" do
  #   it "should remove inw_unapproved_record if the approval_status is 'A' and there is unapproved_record" do
  #     user_role = Factory(:user_role, :approval_status => 'U')
  #     user_role.reload
  #     user_role.inw_unapproved_record.should_not be_nil
  #     record = user_role.inw_unapproved_record
  #     user_role.user_id = 8
  #     user_role.save
  #     user_role.inw_unapproved_record.should == record
  #     user_role.approval_status = 'A'
  #     user_role.save
  #     user_role.remove_inw_unapproved_records
  #     user_role.reload
  #     user_role.inw_unapproved_record.should be_nil
  #   end
  # end

  context "approve" do 
    it "should approve unapproved_record" do 
      user_role = Factory(:user_role, :approval_status => 'U')
      user_role.approve.should == ""
      user_role.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      user_role = Factory(:user_role, :approval_status => 'A')
      user_role2 = Factory(:user_role, :approval_status => 'U', :approved_id => user_role.id, :approved_version => 6)
      user_role2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      user_role1 = Factory(:user_role, :approval_status => 'A')
      user_role2 = Factory(:user_role, :approval_status => 'U')
      user_role1.enable_approve_button?.should == false
      user_role2.enable_approve_button?.should == true
    end
  end
  
end