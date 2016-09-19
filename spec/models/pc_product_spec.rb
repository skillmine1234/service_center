require 'spec_helper'

describe PcProduct do
  context "associations" do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end
  
  context "validations" do
    [:code, :mm_host, :mm_consumer_key, :mm_consumer_secret, :mm_card_type, :mm_email_domain, :mm_admin_host, :mm_admin_user, :mm_admin_password].each do |att|
      it { should validate_presence_of(att)}
    end
  end

  it do 
    pc_product = Factory(:pc_product, :approval_status => 'A') 
    should validate_uniqueness_of(:code).scoped_to(:approval_status)
  end

  it "should return error if code is already taken" do
    pc_product1 = Factory(:pc_product, :code => "9001", :approval_status => 'A') 
    pc_product2 = Factory.build(:pc_product, :code => "9001", :approval_status => 'A')
    pc_product2.should_not be_valid
    pc_product2.errors_on(:code).should == ["has already been taken"]
  end
  
  context "mm_consumer_key, mm_consumer_secret, mm_card_type format" do 
    [:code, :mm_consumer_key, :mm_consumer_secret, :mm_card_type].each do |att|
      it "should allow valid format" do
        should allow_value('1234567890').for(att)
        should allow_value('Abcd1234567890').for(att)
      end

      it "should not allow invalid format" do
        should_not allow_value('Absdjhsd&&').for(att)
        should_not allow_value('@AbcCo').for(att)
        should_not allow_value('/ab0QWER').for(att)
      end
    end 
  end
  
  context "mm_host , mm_admin_host format" do
    [:mm_host, :mm_admin_host].each do |att|
      it "should allow valid format" do
        should allow_value('http://localhost:3000/pc_products').for(att)
        should allow_value('localhost:3000').for(att)
      end
    
      it "should not allow invalid format" do
        should_not allow_value('localhost').for(att)
        should_not allow_value('@#@localhost').for(att)
      end
    end
  end
  
  context "mm_email_domain format" do
    it "should allow valid format" do
      should allow_value('Domain').for(:mm_email_domain)
      should allow_value('Domain.abc').for(:mm_email_domain)
    end
    
    it "should not allow invalid format" do
      should_not allow_value('Domain 1234').for(:mm_email_domain)
      should_not allow_value('@#@domain').for(:mm_email_domain)
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      pc_product1 = Factory(:pc_product, :approval_status => 'A') 
      pc_product2 = Factory(:pc_product)
      PcProduct.all.should == [pc_product1]
      pc_product2.approval_status = 'A'
      pc_product2.save
      PcProduct.all.should == [pc_product1,pc_product2]
    end
  end  

  context "to_downcase" do 
    it "should convert the code to lower case" do 
      pc_product = Factory.build(:pc_product, :code => "BANK123")
      pc_product.to_downcase
      pc_product.code.should == "bank123"
      pc_product.save.should be_true
    end
  end  

  context "encrypt_password" do 
    it "should convert the encrypt the mm_admin_password for unapproved record" do 
      pc_product = Factory.build(:pc_product, :code => "BANK123", :mm_admin_password => 'password')
      pc_product.save.should be_true
      pc_product.reload
      pc_product.mm_admin_password.should_not == "password"
    end

    it "should not convert the encrypt the mm_admin_password for approved record" do 
      pc_product = Factory.build(:pc_product, :code => "BANK123", :mm_admin_password => 'password', :approval_status => 'A')
      pc_product.save.should be_true
      pc_product.reload
      pc_product.mm_admin_password.should == "password"
    end
  end  

  context "pc_unapproved_records" do 
    it "oncreate: should create pc_unapproved_record if the approval_status is 'U'" do
      pc_product = Factory(:pc_product)
      pc_product.reload
      pc_product.pc_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create pc_unapproved_record if the approval_status is 'A'" do
      pc_product = Factory(:pc_product, :approval_status => 'A')
      pc_product.pc_unapproved_record.should be_nil
    end

    it "onupdate: should not remove pc_unapproved_record if approval_status did not change from U to A" do
      pc_product = Factory(:pc_product)
      pc_product.reload
      pc_product.pc_unapproved_record.should_not be_nil
      record = pc_product.pc_unapproved_record
      # we are editing the U record, before it is approved
      pc_product.mm_admin_user = 'Fooo'
      pc_product.save
      pc_product.reload
      pc_product.pc_unapproved_record.should == record
    end
    
    it "onupdate: should remove pc_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      pc_product = Factory(:pc_product)
      pc_product.reload
      pc_product.pc_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      pc_product.approval_status = 'A'
      pc_product.save
      pc_product.reload
      pc_product.pc_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove pc_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      pc_product = Factory(:pc_product)
      pc_product.reload
      pc_product.pc_unapproved_record.should_not be_nil
      record = pc_product.pc_unapproved_record
      # the approval process destroys the U record, for an edited record 
      pc_product.destroy
      PcUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      pc_product = Factory(:pc_product, :approval_status => 'U')
      password = pc_product.mm_admin_password
      pc_product.approve.should == ""
      pc_product.approval_status.should == 'A'
      pc_product.mm_admin_password.should == password
    end

    it "should return error when trying to approve unmatched version" do 
      pc_product = Factory(:pc_product, :approval_status => 'A')
      pc_product2 = Factory(:pc_product, :approval_status => 'U', :approved_id => pc_product.id, :approved_version => 6)
      pc_product2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      pc_product1 = Factory(:pc_product, :approval_status => 'A')
      pc_product2 = Factory(:pc_product, :approval_status => 'U')
      pc_product1.enable_approve_button?.should == false
      pc_product2.enable_approve_button?.should == true
    end
  end

  context "options_for_pc_programs" do
    it "should return all approved pc_programs records" do
      pc_program1 = Factory(:pc_program, :code => "9967", :approval_status => 'A')
      pc_program2 = Factory(:pc_program, :code => "9968", :approval_status => 'A')
      pc_program3 = Factory(:pc_program, :code => "9969", :approval_status => 'A')
      pc_program4 = Factory(:pc_program, :code => "9970")
      expect(PcProduct.options_for_pc_programs).to eq([["9967", "9967"], ["9968", "9968"], ["9969", "9969"], ["9970", "9970"]])
    end
  end
end
