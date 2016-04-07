require 'spec_helper'

describe ImtCustomer do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:imt_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end
  
  context 'validation' do
    [:customer_code, :customer_name, :contact_person, :email_id, :account_no, :mobile_no, 
     :txn_mode, :expiry_period, :app_id, :identity_user_id].each do |att|
      it { should validate_presence_of(att) }
    end
    
    it { should validate_numericality_of(:expiry_period) }
    
    it do
      imt_customer = Factory(:imt_customer, :app_id => 'App10', :approval_status => 'A')
      should validate_uniqueness_of(:app_id).scoped_to(:approval_status)
    end
  end
  
  context "customer_code format" do 
    it "should allow valid format" do
      should allow_value('9876').for(:customer_code)
      should allow_value('8888').for(:customer_code)
    end 
    
    it "should not allow invalid format" do
      should_not allow_value('@CUST01').for(:customer_code)
      should_not allow_value('CUST01/').for(:customer_code)
      should_not allow_value('CUST-01').for(:customer_code)
    end     
  end
  
  context "customer_name format" do 
    it "should allow valid format" do
      should allow_value('DigitalSoln.').for(:customer_name)
      should allow_value('Digital Soln.').for(:customer_name)
    end 
  
    it "should not allow invalid format" do
      should_not allow_value('@CUST01').for(:customer_name)
      should_not allow_value('CUST01/').for(:customer_name)
      should_not allow_value('CUST-01').for(:customer_name)
    end 
  end
  
  context "contact_person format" do
    it "should allow valid format" do
      should allow_value('John Mathew').for(:contact_person)
      should allow_value('JohnM').for(:contact_person)
    end 
  
    it "should not allow invalid format" do
      should_not allow_value('@John01').for(:contact_person)
      should_not allow_value('John01/').for(:contact_person)
      should_not allow_value('John-01').for(:contact_person)
    end  
  end
  
  context "address_line format" do 
    [:address_line1, :address_line2, :address_line3].each do |att|
      it "should allow valid format" do
        should allow_value('Gandhinagar, 2nd St.').for(att)
        should allow_value('Gandhinagar, 2nd St. - 670307').for(att)
      end 
    
      it "should not allow invalid format" do
        should_not allow_value('@CUST01').for(att)
        should_not allow_value('CUST01/').for(att)
      end
    end   
  end
  
  context "email_id format" do 
    it "should allow valid format" do
      should allow_value('abc@g.in').for(:email_id)
      should allow_value('abc@gmail.com').for(:email_id)
    end 
    
    it "should not allow invalid format" do
      should_not allow_value('as@gg.c').for(:email_id)
      should_not allow_value('@CUST01').for(:email_id)
      should_not allow_value('CUST01/').for(:email_id)
      should_not allow_value('CUST-01').for(:email_id)
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
  
  context ":mobile_no format" do 
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
      imt_customer = Factory.build(:imt_customer, :country => 'US')
      imt_customer.country_name.should == 'United States'
      imt_customer = Factory.build(:imt_customer, :country => nil)
      imt_customer.country_name.should == nil
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      imt_customer1 = Factory(:imt_customer, :approval_status => 'A') 
      imt_customer2 = Factory(:imt_customer, :customer_name => '12we', :app_id => '1111')
      ImtCustomer.all.should == [imt_customer1]
      imt_customer2.approval_status = 'A'
      imt_customer2.save
      ImtCustomer.all.should == [imt_customer1,imt_customer2]
    end
  end    

  context "imt_unapproved_records" do 
    it "oncreate: should create imt_unapproved_record if the approval_status is 'U'" do
      imt_customer = Factory(:imt_customer)
      imt_customer.reload
      imt_customer.imt_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create imt_unapproved_record if the approval_status is 'A'" do
      imt_customer = Factory(:imt_customer, :approval_status => 'A')
      imt_customer.imt_unapproved_record.should be_nil
    end

    it "onupdate: should not remove imt_unapproved_record if approval_status did not change from U to A" do
      imt_customer = Factory(:imt_customer)
      imt_customer.reload
      imt_customer.imt_unapproved_record.should_not be_nil
      record = imt_customer.imt_unapproved_record
      # we are editing the U record, before it is approved
      imt_customer.customer_name = 'Fooo'
      imt_customer.save
      imt_customer.reload
      imt_customer.imt_unapproved_record.should == record
    end
    
    it "onupdate: should remove imt_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      imt_customer = Factory(:imt_customer)
      imt_customer.reload
      imt_customer.imt_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      imt_customer.approval_status = 'A'
      imt_customer.save
      imt_customer.reload
      imt_customer.imt_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove imt_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      imt_customer = Factory(:imt_customer)
      imt_customer.reload
      imt_customer.imt_unapproved_record.should_not be_nil
      record = imt_customer.imt_unapproved_record
      # the approval process destroys the U record, for an edited record 
      imt_customer.destroy
      ImtUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      imt_customer = Factory(:imt_customer, :approval_status => 'U')
      imt_customer.approve.should == ""
      imt_customer.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      imt_customer = Factory(:imt_customer, :approval_status => 'A')
      imt_customer1 = Factory(:imt_customer, :approval_status => 'U', :approved_id => imt_customer.id, :approved_version => 6)
      imt_customer1.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      imt_customer1 = Factory(:imt_customer, :approval_status => 'A')
      imt_customer2 = Factory(:imt_customer, :approval_status => 'U')
      imt_customer1.enable_approve_button?.should == false
      imt_customer2.enable_approve_button?.should == true
    end
  end
  
  context "options_for_processing_method" do
    it "should return options for processing method" do
      ImtCustomer.options_for_txn_mode.should == [['File','F'],['Api','A']]
    end
  end
  
  context "convert_customer_name_to_upcase" do
    it "should convert customer_name to upcase" do
      imt_customer = Factory(:imt_customer, :customer_name => "john")
      imt_customer.reload
      imt_customer.customer_name.should == "JOHN"
    end
  end
end