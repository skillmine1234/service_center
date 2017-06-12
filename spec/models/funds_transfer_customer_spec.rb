require 'spec_helper'

describe FundsTransferCustomer do
  include HelperMethods

  before(:each) do
    mock_ldap
  end

  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:ft_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
    it { should have_many(:ft_customer_accounts) }
  end
  
  context 'validation' do
    [:low_balance_alert_at, :identity_user_id, :name, :app_id, :allow_all_accounts, :is_filetoapi_allowed].each do |att|
      it { should validate_presence_of(att) }
    end

    it do 
      funds_transfer_customer = Factory(:funds_transfer_customer, :approval_status => 'A')
      should validate_uniqueness_of(:app_id).scoped_to(:customer_id,:approval_status)  

      should validate_length_of(:app_id).is_at_least(5).is_at_most(20)
      should validate_length_of(:customer_id).is_at_most(10)
      should validate_length_of(:name).is_at_most(100)
      should validate_length_of(:identity_user_id).is_at_most(20)
      should validate_length_of(:notify_app_code).is_at_most(20)
    end

    it "should not allow invalid format" do
      ft_customer = Factory.build(:funds_transfer_customer, :customer_id => '111.11', :app_id => '@acddsfdfd', :name => 'ABC@DEF')
      ft_customer.save == false
      [:app_id].each do |att|
        ft_customer.errors_on(att).should == ["Invalid format, expected format is : {[a-z|A-Z|0-9]}"]
      end
      [:customer_id].each do |att|
        ft_customer.errors_on(att).should == ["Invalid format, expected format is : {[0-9]}"]
      end
      ft_customer.errors_on(:name).should == ["Invalid format, expected format is : {[a-z|A-Z|0-9|\\s|\\.|\\-]}"]
    end

    context "customer_id" do 
      it "should be mandatory if is_retail is 'N'" do 
        funds_transfer_customer = Factory.build(:funds_transfer_customer, :is_retail => 'N', :customer_id => nil)
        funds_transfer_customer.should_not be_valid
        funds_transfer_customer.errors_on(:customer_id).should == ["is mandatory for corporate"]
      end

      it "should not be mandatory if is_retail is 'Y'" do 
        funds_transfer_customer = Factory.build(:funds_transfer_customer, :is_retail => 'Y', :customer_id => nil)
        funds_transfer_customer.should be_valid
        funds_transfer_customer.errors_on(:customer_id).should == []
      end
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
      funds_transfer_customer2 = Factory(:funds_transfer_customer, :name => '12we')
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
  
  context "presence_of_iam_cust_user" do
    it "should validate existence of iam_cust_user" do
      funds_transfer_customer = Factory.build(:funds_transfer_customer, identity_user_id: '1234')
      funds_transfer_customer.errors_on(:identity_user_id).should == ['IAM Customer User does not exist for this username']
      
      iam_cust_user = Factory(:iam_cust_user, username: '1234', approval_status: 'A')
      funds_transfer_customer.errors_on(:identity_user_id).should == []
    end
  end
  
  context "should_allow_neft?" do
    it "should allow neft for the funds_transfer_customer when the customer setup is complete in FCR" do
      fcr_customer = Factory(:fcr_customer, cod_cust_id: '2345', ref_phone_mobile: '2222222222', ref_cust_email: 'aaa@gmail.com')
      funds_transfer_customer = Factory.build(:funds_transfer_customer, customer_id: '2345', allow_neft: 'Y', allow_imps: 'N')
      funds_transfer_customer.errors_on(:customer_id).should == []
    end

    it "should raise error when the mobile no. and email are not present in the customer setup in FCR" do
      fcr_customer = Factory(:fcr_customer, cod_cust_id: '2345', ref_phone_mobile: '2222222222', ref_cust_email: nil)
      funds_transfer_customer = Factory.build(:funds_transfer_customer, customer_id: '2345', allow_neft: 'Y', allow_imps: 'N')
      funds_transfer_customer.errors_on(:allow_neft).should == ["NEFT is not allowed for 2345 as the data setup in FCR is invalid"]
    end

    it "should raise error when there is no corresponding record in FCR" do
      fcr_customer = Factory(:fcr_customer, cod_cust_id: '2345', ref_phone_mobile: '2222222222', ref_cust_email: 'aaa@gmail.com')
      funds_transfer_customer = Factory.build(:funds_transfer_customer, customer_id: '234', allow_neft: 'Y', allow_imps: 'N')
      funds_transfer_customer.errors_on(:customer_id).should == ["no record found in FCR for 234"]
    end
  end
  
  context "should_allow_imps?" do
    it "should allow imps for the funds_transfer_customer when the customer setup is complete in FCR and ATOM" do
      fcr_customer = Factory(:fcr_customer, cod_cust_id: '2345', ref_phone_mobile: '2222222222', ref_cust_email: 'aaa@gmail.com')
      fcr_cust_acct = Factory(:fcr_cust_acct, cod_cust: '2345', cod_acct_cust_rel: 'GUR', cod_acct_no: '1234567890')
      atom_customer = Factory(:atom_customer, customerid: '2345', mobileno: '2222222222', isactive: '1')
      funds_transfer_customer = Factory.build(:funds_transfer_customer, customer_id: '2345', allow_neft: 'N', allow_imps: 'Y', allow_all_accounts: 'Y')
      funds_transfer_customer.errors_on(:customer_id).should == []
    end

    it "should raise error when there is no corresponding record in FCR" do
      fcr_customer = Factory(:fcr_customer, cod_cust_id: '2345', ref_phone_mobile: '2222222222', ref_cust_email: 'aaa@gmail.com')
      fcr_cust_acct = Factory(:fcr_cust_acct, cod_cust: '2345', cod_acct_cust_rel: 'GUR', cod_acct_no: '1234500000')
      atom_customer = Factory(:atom_customer, customerid: '2345', mobileno: '2222222222', isactive: '1', accountno: '1234567890')
      funds_transfer_customer = Factory.build(:funds_transfer_customer, customer_id: '234', allow_neft: 'N', allow_imps: 'Y', allow_all_accounts: 'Y')
      funds_transfer_customer.errors_on(:customer_id).should == ["no record found in FCR for 234"]
    end
    
    it "should raise error when there is no accounts in FCR for any the customer" do
      fcr_customer = Factory(:fcr_customer, cod_cust_id: '2345', ref_phone_mobile: '2222222222', ref_cust_email: 'aaa@gmail.com')
      fcr_cust_acct = Factory(:fcr_cust_acct, cod_cust: '0000', cod_acct_cust_rel: 'GUR', cod_acct_no: '1234500000')
      atom_customer = Factory(:atom_customer, customerid: '2345', mobileno: '2222222222', isactive: '1', accountno: '1234567890')
      funds_transfer_customer = Factory.build(:funds_transfer_customer, customer_id: '2345', allow_neft: 'N', allow_imps: 'Y', allow_all_accounts: 'Y')
      funds_transfer_customer.errors_on(:base).should == ["no accounts found in FCR for 2345"]
    end

    it "should raise error when the mobile no.s in FCR and ATOM do not match for the customer" do
      atom_customer = Factory(:atom_customer, customerid: '2345', mobileno: '2222222222', isactive: '1', accountno: '1234567890')
      fcr_cust_acct = Factory(:fcr_cust_acct, cod_cust: '2345', cod_acct_cust_rel: 'GUR', cod_acct_no: '1234567890')
      fcr_customer = Factory(:fcr_customer, cod_cust_id: '2345', ref_phone_mobile: '9999000099', ref_cust_email: 'aaa@gmail.com')
      funds_transfer_customer = Factory.build(:funds_transfer_customer, customer_id: '2345', allow_neft: 'N', allow_imps: 'Y', allow_all_accounts: 'Y')
      funds_transfer_customer.errors_on(:base).should == ["IMPS is not allowed for account_no 1234567890"]
    end
  end
end
