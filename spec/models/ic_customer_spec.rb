require 'spec_helper'

describe IcCustomer do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:ic_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end
  
  context 'validation' do
    [:customer_id, :app_id, :repay_account_no, :fee_pct, 
     :fee_income_gl, :max_overdue_pct, :cust_contact_email, :cust_contact_mobile, 
     :ops_email, :rm_email, :is_enabled, :customer_name].each do |att|
      it { should validate_presence_of(att) }
    end

    it do
      ic_customer = Factory(:ic_customer, :approval_status => 'A')

      should validate_length_of(:customer_id).is_at_least(3).is_at_most(15)
      should validate_length_of(:app_id).is_at_least(5).is_at_most(20)

      [:identity_user_id, :repay_account_no, :fee_income_gl].each do |att|
        should validate_length_of(att).is_at_most(20)
      end

      [:cust_contact_email, :ops_email, :rm_email, :customer_name].each do |att|
        should validate_length_of(att).is_at_most(100)
      end

      should validate_length_of(:cust_contact_mobile).is_at_least(10).is_at_most(10)

      should allow_value(nil).for(:identity_user_id)
    end

    it do 
      ic_customer = Factory(:ic_customer, :approval_status => 'A')
      should validate_uniqueness_of(:customer_id).scoped_to(:approval_status)
    end

    it "should return error if customer_id is already taken" do
      ic_customer1 = Factory(:ic_customer, :customer_id => "9001", :approval_status => 'A')
      ic_customer2 = Factory.build(:ic_customer, :customer_id => "9001", :approval_status => 'A')
      ic_customer2.should_not be_valid
      ic_customer2.errors_on(:customer_id).should == ["has already been taken"]
    end

    it "should return error when percentages fields > 100" do
      ic_customer1 = Factory.build(:ic_customer, :fee_pct => 100.10)
      ic_customer1.should_not be_valid
      ic_customer1.errors_on(:fee_pct).should == ["must be less than or equal to 100"]
      ic_customer2 = Factory.build(:ic_customer, :max_overdue_pct => 100.10)
      ic_customer2.should_not be_valid
      ic_customer2.errors_on(:max_overdue_pct).should == ["must be less than or equal to 100"]
    end

    it "should return error when percentages fields < 0" do
      ic_customer1 = Factory.build(:ic_customer, :fee_pct => -1.1)
      ic_customer1.should_not be_valid
      ic_customer1.errors_on(:fee_pct).should == ["must be greater than or equal to 0"]
      ic_customer2 = Factory.build(:ic_customer, :max_overdue_pct => -1.1)
      ic_customer2.should_not be_valid
      ic_customer2.errors_on(:max_overdue_pct).should == ["must be greater than or equal to 0"]
    end

    it "should save the record when percentages fields is between 0 & 100" do
      ic_customer1 = Factory.build(:ic_customer, :fee_pct => 45.55)
      ic_customer1.should be_valid
      ic_customer1.errors_on(:fee_pct).should == []
      ic_customer2 = Factory.build(:ic_customer, :max_overdue_pct => 45.55)
      ic_customer2.should be_valid
      ic_customer2.errors_on(:max_overdue_pct).should == []
    end
  end

  context "fields format" do
    it "should allow valid format" do
      [:customer_id, :app_id, :identity_user_id, :repay_account_no, :fee_income_gl, :cust_contact_mobile].each do |att|
        should allow_value('0123456789').for(att)
      end

      [:identity_user_id, :app_id].each do |att|
        should allow_value('ABC123').for(att)
      end

      [:fee_pct, :max_overdue_pct].each do |att|
        should allow_value('88.88').for(att)
      end
    end

    it "should not allow invalid format" do
      ic_customer = Factory.build(:ic_customer, :customer_id => '111.11', :app_id => '@acddsfdfd', 
                                  :identity_user_id => "IUID-1", :repay_account_no => "ACC01", :fee_pct => "45.5f", 
                                  :fee_income_gl => "400$", :max_overdue_pct => "77f", :cust_contact_mobile => "MOB99-0999", :customer_name => 'ABC@DEF')
      ic_customer.save == false
      [:identity_user_id, :app_id].each do |att|
        ic_customer.errors_on(att).should == ["Invalid format, expected format is : {[a-z|A-Z|0-9]}"]
      end
      [:customer_id, :repay_account_no, :fee_income_gl, :cust_contact_mobile].each do |att|
        ic_customer.errors_on(att).should == ["Invalid format, expected format is : {[0-9]}"]
      end
      ic_customer.errors_on(:customer_name).should == ["Invalid format, expected format is : {[a-z|A-Z|0-9|\\s|\\.|\\-]}"]
    end
  end

  context "email_id format" do 
    [:cust_contact_email, :ops_email, :rm_email].each do |att|
      it "should allow valid format" do
        should allow_value('abc@g.in').for(att)
        should allow_value('abc@gmail.com').for(att)
      end
    
      it "should not allow invalid format" do
        should_not allow_value('as@gg.c').for(att)
        should_not allow_value('@CUST01').for(att)
        should_not allow_value('CUST01/').for(att)
        should_not allow_value('CUST-01').for(att)
      end
    end    
  end

  context "check_email_addresses" do 
    it "should validate email address" do 
      ic_customer = Factory.build(:ic_customer, :cust_contact_email => "1234;esesdgs", :ops_email => "1234;esesdgs", :rm_email => "1234;esesdgs")
      ic_customer.should_not be_valid
      ic_customer.errors_on("cust_contact_email").should == ["is invalid, expected format is abc@def.com"]
      ic_customer.errors_on("ops_email").should == ["is invalid, expected format is abc@def.com"]
      ic_customer.errors_on("rm_email").should == ["is invalid, expected format is abc@def.com"]
      ic_customer = Factory.build(:ic_customer, :cust_contact_email => "foo@ruby.com;abe@def.com", :ops_email => "foo@ruby.com;bar@ruby.com", :rm_email => "foo@ruby.com;bar@ruby.com")
      ic_customer.should be_valid
    end
  end

  context "customer_name format" do
    it "should allow valid format" do
      should allow_value('ABCDCo').for(:customer_name)
      should allow_value('ABCD Co').for(:customer_name)
      should allow_value('ABCD.Co').for(:customer_name)
      should allow_value('ABCD-Co').for(:customer_name)
    end

    it "should not allow invalid format" do
      should_not allow_value('@AbcCo').for(:customer_name)
      should_not allow_value('/ab0QWER').for(:customer_name)
    end
  end

  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      ic_customer1 = Factory(:ic_customer, :approval_status => 'A') 
      ic_customer2 = Factory(:ic_customer, :customer_id => '9008')
      ic_customers = IcCustomer.all
      IcCustomer.all.should == [ic_customer1]
      ic_customer2.approval_status = 'A'
      ic_customer2.save
      IcCustomer.all.should == [ic_customer1,ic_customer2]
    end
  end    

  context "su_unapproved_records" do 
    it "oncreate: should create ic_unapproved_record if the approval_status is 'U'" do
      ic_customer = Factory(:ic_customer)
      ic_customer.reload
      ic_customer.ic_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create ic_unapproved_record if the approval_status is 'A'" do
      ic_customer = Factory(:ic_customer, :approval_status => 'A')
      ic_customer.ic_unapproved_record.should be_nil
    end

    it "onupdate: should not remove ic_unapproved_record if approval_status did not change from U to A" do
      ic_customer = Factory(:ic_customer)
      ic_customer.reload
      ic_customer.ic_unapproved_record.should_not be_nil
      record = ic_customer.ic_unapproved_record
      # we are editing the U record, before it is approved
      ic_customer.repay_account_no = '1234567892'
      ic_customer.save
      ic_customer.reload
      ic_customer.ic_unapproved_record.should == record
    end
    
    it "onupdate: should remove ic_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      ic_customer = Factory(:ic_customer)
      ic_customer.reload
      ic_customer.ic_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      ic_customer.approval_status = 'A'
      ic_customer.save
      ic_customer.reload
      ic_customer.ic_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove ic_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      ic_customer = Factory(:ic_customer)
      ic_customer.reload
      ic_customer.ic_unapproved_record.should_not be_nil
      record = ic_customer.ic_unapproved_record
      # the approval process destroys the U record, for an edited record 
      ic_customer.destroy
      IcUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      ic_customer = Factory(:ic_customer, :approval_status => 'U')
      ic_customer.approve.should == ""
      ic_customer.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      ic_customer = Factory(:ic_customer, :approval_status => 'A')
      ic_customer1 = Factory(:ic_customer, :approval_status => 'U', :approved_id => ic_customer.id, :approved_version => 6)
      ic_customer1.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      ic_customer1 = Factory(:ic_customer, :approval_status => 'A')
      ic_customer2 = Factory(:ic_customer, :approval_status => 'U')
      ic_customer1.enable_approve_button?.should == false
      ic_customer2.enable_approve_button?.should == true
    end
  end
  
end
