require 'spec_helper'

describe User do 
  context 'association' do
    it { should belong_to(:role) }
  end

  context "has_role" do 
    it "should return true if the user has_role" do 
      user = Factory(:user, :role_id => Factory(:role, :name => :user).id)
      user.has_role?(:user).should === true
      user.has_role?(:editor).should === false
      user.has_role?(:approver).should === false
    end
  end

  context "group_names" do 
    it "should return names if the user has_role" do 
      user = Factory(:user)
      user.group_names.should == ["inward-remittance","e-collect"]
    end
  end
end
