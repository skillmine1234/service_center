require 'spec_helper'

describe FundsTransferCustomer do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:ft_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end
  
  context 'validation' do
    [:account_no, :account_ifsc, :low_balance_alert_at, :identity_user_id, :customer_id, :name].each do |att|
      it { should validate_presence_of(att) }
    end
    
    [:low_balance_alert_at, :mmid, :customer_id].each do |att|
      it { should validate_numericality_of(att) }
    end

    it do 
      funds_transfer_customer = Factory(:funds_transfer_customer, :approval_status => 'A')
      should validate_uniqueness_of(:customer_id).scoped_to(:approval_status)   
    end
  end

  context "email_id format" do 
    [:tech_email_id, :ops_email_id].each do |att|
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

  context "account_no format" do 
    it "should allow valid format" do
      should allow_value('987654310').for(:account_no)
      should allow_value('8888000').for(:account_no)
    end 
    
    it "should not allow invalid format" do
      should_not allow_value('@CUST01').for(:account_no)
      should_not allow_value('CUST01/').for(:account_no)
      should_not allow_value('CUST-01').for(:account_no)
    end     
  end
  
  context "account_ifsc format" do 
    it "should allow valid format" do
      should allow_value('ASDE0123456').for(:account_ifsc)
      should allow_value('QQWE0987898').for(:account_ifsc)
    end 
    
    it "should not allow invalid format" do
      should_not allow_value('1234567890').for(:account_ifsc)
      should_not allow_value('ASD123456').for(:account_ifsc)
      should_not allow_value('CUST-01!').for(:account_ifsc)
    end     
  end
  
  context "mobile_no format" do 
    it "should allow valid format" do
      should allow_value('9087654321').for(:mobile_no)
    end 
    
    it "should not allow invalid format" do
      should_not allow_value('@CUST01').for(:mobile_no)
      should_not allow_value('CUST01/').for(:mobile_no)
      should_not allow_value('CUST-01').for(:mobile_no)
    end     
  end
  
  context "country_name" do 
    it "should return full name for the country code" do 
      funds_transfer_customer = Factory.build(:funds_transfer_customer, :country => 'US')
      funds_transfer_customer.country_name.should == 'United States'
      funds_transfer_customer = Factory.build(:funds_transfer_customer, :country => nil)
      funds_transfer_customer.country_name.should == nil
    end
  end

  context "customer name format" do
    it "should allow valid format" do
      should allow_value('ABCDCo').for(:name)
      should allow_value('ABCD Co').for(:name)
    end

    it "should not allow invalid format" do
      should_not allow_value('@AbcCo').for(:name)
      should_not allow_value('/ab0QWER').for(:name)
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      funds_transfer_customer1 = Factory(:funds_transfer_customer, :approval_status => 'A') 
      funds_transfer_customer2 = Factory(:funds_transfer_customer, :name => '12we', :customer_id => "23456789")
      FundsTransferCustomer.all.should == [funds_transfer_customer1]
      funds_transfer_customer2.approval_status = 'A'
      funds_transfer_customer2.save
      FundsTransferCustomer.all.should == [funds_transfer_customer1,funds_transfer_customer2]
    end
  end    

  context "ft_unapproved_records" do 
    it "oncreate: should create ft_unapproved_record if the approval_status is 'U'" do
      funds_transfer_customer = Factory(:funds_transfer_customer)
      funds_transfer_customer.reload
      funds_transfer_customer.ft_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create ft_unapproved_record if the approval_status is 'A'" do
      funds_transfer_customer = Factory(:funds_transfer_customer, :approval_status => 'A')
      funds_transfer_customer.ft_unapproved_record.should be_nil
    end

    it "onupdate: should not remove ft_unapproved_record if approval_status did not change from U to A" do
      funds_transfer_customer = Factory(:funds_transfer_customer)
      funds_transfer_customer.reload
      funds_transfer_customer.ft_unapproved_record.should_not be_nil
      record = funds_transfer_customer.ft_unapproved_record
      # we are editing the U record, before it is approved
      funds_transfer_customer.name = 'Fooo'
      funds_transfer_customer.save
      funds_transfer_customer.reload
      funds_transfer_customer.ft_unapproved_record.should == record
    end
    
    it "onupdate: should remove ft_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      funds_transfer_customer = Factory(:funds_transfer_customer)
      funds_transfer_customer.reload
      funds_transfer_customer.ft_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      funds_transfer_customer.approval_status = 'A'
      funds_transfer_customer.save
      funds_transfer_customer.reload
      funds_transfer_customer.ft_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove ft_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      funds_transfer_customer = Factory(:funds_transfer_customer)
      funds_transfer_customer.reload
      funds_transfer_customer.ft_unapproved_record.should_not be_nil
      record = funds_transfer_customer.ft_unapproved_record
      # the approval process destroys the U record, for an edited record 
      funds_transfer_customer.destroy
      FtUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      funds_transfer_customer = Factory(:funds_transfer_customer, :approval_status => 'U')
      funds_transfer_customer.approve.should == ""
      funds_transfer_customer.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      funds_transfer_customer = Factory(:funds_transfer_customer, :approval_status => 'A')
      funds_transfer_customer1 = Factory(:funds_transfer_customer, :approval_status => 'U', :approved_id => funds_transfer_customer.id, :approved_version => 6)
      funds_transfer_customer1.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      funds_transfer_customer1 = Factory(:funds_transfer_customer, :approval_status => 'A')
      funds_transfer_customer2 = Factory(:funds_transfer_customer, :approval_status => 'U')
      funds_transfer_customer1.enable_approve_button?.should == false
      funds_transfer_customer2.enable_approve_button?.should == true
    end
  end
  
  context "validate_presence_of_mmid" do
    it "should validate presence of mmid if neft is allowed" do
      funds_transfer_customer = Factory.build(:funds_transfer_customer, :allow_imps => 'Y', :mmid => nil)
      funds_transfer_customer.save.should == false
      funds_transfer_customer.errors_on(:mmid).should == ["MMID is mandatory if IMPS is allowed"]
      funds_transfer_customer = Factory.build(:funds_transfer_customer, :allow_imps => 'N', :mmid => nil)
      funds_transfer_customer.save.should == true
    end
  end
end
