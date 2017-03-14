require 'spec_helper'

describe IcSupplier do
  include HelperMethods

  before(:each) do
    mock_ldap
  end

  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:ic_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end
  
  context 'validation' do
    [:supplier_code, :supplier_name, :customer_id, :corp_customer_id, :od_account_no, :ca_account_no, :is_enabled].each do |att|
      it { should validate_presence_of(att) }
    end

    it do
      ic_supplier = Factory(:ic_supplier, :approval_status => 'A')

      should validate_length_of(:customer_id).is_at_least(3).is_at_most(10)
      should validate_length_of(:corp_customer_id).is_at_least(3).is_at_most(10)
      should validate_length_of(:supplier_code).is_at_least(3).is_at_most(10)

      [:od_account_no, :ca_account_no].each do |att|
        should validate_length_of(att).is_at_least(10).is_at_most(20)
      end

      should validate_length_of(:supplier_name).is_at_most(100)
    end

    it do 
      ic_supplier = Factory(:ic_supplier, :approval_status => 'A')
      should validate_uniqueness_of(:supplier_code).scoped_to(:customer_id, :approval_status)
    end

    it "should return error if supplier_code is already taken" do
      ic_supplier1 = Factory(:ic_supplier, :supplier_code => "9001", :customer_id => "8001", :approval_status => 'A')
      ic_supplier2 = Factory.build(:ic_supplier, :supplier_code => "9001", :customer_id => "8001", :approval_status => 'A')
      ic_supplier2.should_not be_valid
      ic_supplier2.errors_on(:supplier_code).should == ["has already been taken"]
    end

    it "should return error if corp_customer_id not present in customer_id" do
      ic_supplier1 = Factory.build(:ic_supplier, :corp_customer_id => "1234",:supplier_code => "9001", :customer_id => "8001", :approval_status => 'A')
      ic_supplier1.should_not be_valid
      ic_supplier1.errors_on(:corp_customer_id).should == ["is not present in customers"]
      Factory(:ic_customer, :customer_id => "1234", :approval_status => 'A')
      ic_supplier1.should be_valid
    end
  end

  context "numeric fields format" do
    it "should allow valid format" do
      [:customer_id, :od_account_no, :ca_account_no].each do |att|
        should allow_value('0123456789').for(att)
      end
    end

    it "should not allow invalid format" do
      ic_supplier = Factory.build(:ic_supplier, :customer_id => '@,.9023jsf', :od_account_no => "ODACC-0001", :ca_account_no => "CA-ACC0001", :supplier_code => "SUPL-001@2", :supplier_name => 'ABC@DEF')
      ic_supplier.save == false
      [:customer_id, :od_account_no, :ca_account_no].each do |att|
        ic_supplier.errors_on(att).should == ["Invalid format, expected format is : {[0-9]}"]
      end
      ic_supplier.errors_on(:supplier_code).should == ["Invalid format, expected format is : {[a-z|A-Z|0-9]}"]
      ic_supplier.errors_on(:supplier_name).should == ["Invalid format, expected format is : {[a-z|A-Z|0-9|\\s|\\.|\\-]}"]
    end
  end

  context "supplier_code format" do 
    it "should allow valid format" do
      should allow_value('9876').for(:supplier_code)
      should allow_value('ABCD90').for(:supplier_code)
      should allow_value('ABCD9z0').for(:supplier_code)
    end 
    
    it "should not allow invalid format" do
      should_not allow_value('@CUST01').for(:supplier_code)
      should_not allow_value('CUST01/').for(:supplier_code)
      should_not allow_value('CUST-01').for(:supplier_code)
    end     
  end

  context "supplier_name format" do
    it "should allow valid format" do
      should allow_value('ABCDCo').for(:supplier_name)
      should allow_value('ABCD Co').for(:supplier_name)
      should allow_value('ABCD.Co').for(:supplier_name)
      should allow_value('ABCD-Co').for(:supplier_name)
    end

    it "should not allow invalid format" do
      should_not allow_value('@AbcCo').for(:supplier_name)
      should_not allow_value('/ab0QWER').for(:supplier_name)
    end
  end

  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      ic_supplier1 = Factory(:ic_supplier, :approval_status => 'A') 
      ic_supplier2 = Factory(:ic_supplier, :supplier_code => '9008')
      ic_suppliers = IcSupplier.all
      IcSupplier.all.should == [ic_supplier1]
      ic_supplier2.approval_status = 'A'
      ic_supplier2.save
      IcSupplier.all.should == [ic_supplier1,ic_supplier2]
    end
  end    

  context "su_unapproved_records" do 
    it "oncreate: should create ic_unapproved_record if the approval_status is 'U'" do
      ic_supplier = Factory(:ic_supplier)
      ic_supplier.reload
      ic_supplier.ic_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create ic_unapproved_record if the approval_status is 'A'" do
      ic_supplier = Factory(:ic_supplier, :approval_status => 'A')
      ic_supplier.ic_unapproved_record.should be_nil
    end

    it "onupdate: should not remove ic_unapproved_record if approval_status did not change from U to A" do
      ic_supplier = Factory(:ic_supplier)
      ic_supplier.reload
      ic_supplier.ic_unapproved_record.should_not be_nil
      record = ic_supplier.ic_unapproved_record
      # we are editing the U record, before it is approved
      ic_supplier.supplier_name = 'MyString2'
      ic_supplier.save
      ic_supplier.reload
      ic_supplier.ic_unapproved_record.should == record
    end
    
    it "onupdate: should remove ic_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      ic_supplier = Factory(:ic_supplier)
      ic_supplier.reload
      ic_supplier.ic_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      ic_supplier.approval_status = 'A'
      ic_supplier.save
      ic_supplier.reload
      ic_supplier.ic_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove ic_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      ic_supplier = Factory(:ic_supplier)
      ic_supplier.reload
      ic_supplier.ic_unapproved_record.should_not be_nil
      record = ic_supplier.ic_unapproved_record
      # the approval process destroys the U record, for an edited record 
      ic_supplier.destroy
      IcUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      ic_supplier = Factory(:ic_supplier, :approval_status => 'U')
      ic_supplier.approve.should == ""
      ic_supplier.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      ic_supplier = Factory(:ic_supplier, :approval_status => 'A')
      ic_supplier1 = Factory(:ic_supplier, :approval_status => 'U', :approved_id => ic_supplier.id, :approved_version => 6)
      ic_supplier1.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      ic_supplier1 = Factory(:ic_supplier, :approval_status => 'A')
      ic_supplier2 = Factory(:ic_supplier, :approval_status => 'U')
      ic_supplier1.enable_approve_button?.should == false
      ic_supplier2.enable_approve_button?.should == true
    end
  end
  
end
