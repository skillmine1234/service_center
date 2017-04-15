require 'spec_helper'

describe UserGroup do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:unapproved_record_entry) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end

  context 'validation' do
    [:user_id, :group_id].each do |att|
      it { should validate_presence_of(att) }
    end

    it do
      user_group = Factory(:user_group)
      should validate_uniqueness_of(:user_id).scoped_to(:group_id,:approval_status)
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      UserGroup.delete_all
      user_group1 = Factory(:user_group, :user_id => 2, :approval_status => 'A') 
      user_group2 = Factory(:user_group, :user_id => 3, :approval_status => 'U')
      UserGroup.all.should == [user_group1]
      user_group2.approval_status = 'A'
      user_group2.save
      UserGroup.all.should == [user_group1,user_group2]
    end
  end    

  context "create unapproved_records" do 
    it "should create unapproved_record_entry if the approval_status is 'U' and there is no previous record" do
      user_group = Factory(:user_group, :approval_status => 'U')
      user_group.reload
      user_group.unapproved_record_entry.should_not be_nil
      record = user_group.unapproved_record_entry
      user_group.user_id = 8
      user_group.save
      user_group.unapproved_record_entry.should == record
    end

    it "should not create unapproved_record_entry if the approval_status is 'A'" do
      user_group = Factory(:user_group, :approval_status => 'A')
      user_group.unapproved_record_entry.should be_nil
    end
  end  

  # context "remove_inw_unapproved_records" do
  #   it "should remove inw_unapproved_record if the approval_status is 'A' and there is unapproved_record" do
  #     user_group = Factory(:user_group, :approval_status => 'U')
  #     user_group.reload
  #     user_group.inw_unapproved_record.should_not be_nil
  #     record = user_group.inw_unapproved_record
  #     user_group.user_id = 8
  #     user_group.save
  #     user_group.inw_unapproved_record.should == record
  #     user_group.approval_status = 'A'
  #     user_group.save
  #     user_group.remove_inw_unapproved_records
  #     user_group.reload
  #     user_group.inw_unapproved_record.should be_nil
  #   end
  # end  

  context "approve" do 
    it "should approve unapproved_record" do 
      user_group = Factory(:user_group, :approval_status => 'U')
      user_group.approve.should == ""
      user_group.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      user_group = Factory(:user_group, :approval_status => 'A')
      user_group2 = Factory(:user_group, :approval_status => 'U', :approved_id => user_group.id, :approved_version => 6)
      user_group2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      user_group1 = Factory(:user_group, :approval_status => 'A')
      user_group2 = Factory(:user_group, :approval_status => 'U')
      user_group1.enable_approve_button?.should == false
      user_group2.enable_approve_button?.should == true
    end
  end
  
end