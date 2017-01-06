require 'spec_helper'

describe RcApp do
  context "associations" do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context 'udfs_count' do
    it 'should calculate udfs_cnt' do
      rc_app = Factory(:rc_app, udf1_name: 'udf1', udf1_type: 'number', udf2_name: 'udf2', udf2_type: 'date')
      rc_app.udfs_cnt.should == 2
    end
  end
  
  context "encrypt_password" do 
    it "should not convert the encrypt the http_password for approved record" do 
      rc_app = Factory.build(:rc_app, http_username: 'username', http_password: 'password')
      rc_app.save.should be_true
      rc_app.reload
      rc_app.http_password.should_not == "password"
    end
  end

  context "validation" do    
    it "should validate presence of http_password if http_username is present" do
      rc_app = Factory.build(:rc_app, http_username: 'username', http_password: nil)
      rc_app.save.should == false
      rc_app.errors[:base].should == ["HTTP Password can't be blank if HTTP Username is present"]
    end
  end
end
