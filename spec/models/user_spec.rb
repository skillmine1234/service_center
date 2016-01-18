require 'spec_helper'

describe User do 
  context 'association' do
    it { should have_one(:user_role) }
    it { should have_many(:groups) }
    it { should have_many(:user_groups) }
  end

  context "has_role" do 
    it "should return true if the user has_role" do 
      user = Factory(:user)
      Factory(:user_role, :user_id => user.id, :role_id => Factory(:role, :name => 'user').id)
      user.has_role?(:user).should === true
      user.has_role?(:editor).should === false
      user.has_role?(:supervisor).should === false
    end
  end

  context "group_names" do 
    it "should return names if the user has_role" do 
      user = Factory(:user)
      user.group_names.should == ["inward-remittance","e-collect","bill-management","prepaid-card","flex-proxy","imt"]
    end
  end
end
