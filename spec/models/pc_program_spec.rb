require 'spec_helper'

describe PcProgram do
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
    pc_program = Factory(:pc_program, :approval_status => 'A') 
    should validate_uniqueness_of(:code).scoped_to(:approval_status)
  end

  it "should return error if code is already taken" do
    pc_program1 = Factory(:pc_program, :code => "9001", :approval_status => 'A') 
    pc_program2 = Factory.build(:pc_program, :code => "9001", :approval_status => 'A')
    pc_program2.should_not be_valid
    pc_program2.errors_on(:code).should == ["has already been taken"]
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
  
  context "mm_host format" do
    it "should allow valid format" do
      should allow_value('http://localhost:3000/pc_programs').for(:mm_host)
      should allow_value('localhost:3000').for(:mm_host)
    end
    
    it "should not allow invalid format" do
      should_not allow_value('localhost').for(:mm_host)
      should_not allow_value('@#@localhost').for(:mm_host)
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
      pc_program1 = Factory(:pc_program, :approval_status => 'A') 
      pc_program2 = Factory(:pc_program)
      PcProgram.all.should == [pc_program1]
      pc_program2.approval_status = 'A'
      pc_program2.save
      PcProgram.all.should == [pc_program1,pc_program2]
    end
  end  

  context "to_downcase" do 
    it "should convert the code to lower case" do 
      pc_program = Factory.build(:pc_program, :code => "BANK123")
      pc_program.to_downcase
      pc_program.code.should == "bank123"
      pc_program.save.should be_true
    end
  end  

  context "pc_unapproved_records" do 
    it "oncreate: should create pc_unapproved_record if the approval_status is 'U'" do
      pc_program = Factory(:pc_program)
      pc_program.reload
      pc_program.pc_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create pc_unapproved_record if the approval_status is 'A'" do
      pc_program = Factory(:pc_program, :approval_status => 'A')
      pc_program.pc_unapproved_record.should be_nil
    end

    it "onupdate: should not remove pc_unapproved_record if approval_status did not change from U to A" do
      pc_program = Factory(:pc_program)
      pc_program.reload
      pc_program.pc_unapproved_record.should_not be_nil
      record = pc_program.pc_unapproved_record
      # we are editing the U record, before it is approved
      pc_program.mm_admin_user = 'Fooo'
      pc_program.save
      pc_program.reload
      pc_program.pc_unapproved_record.should == record
    end
    
    it "onupdate: should remove pc_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      pc_program = Factory(:pc_program)
      pc_program.reload
      pc_program.pc_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      pc_program.approval_status = 'A'
      pc_program.save
      pc_program.reload
      pc_program.pc_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove pc_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      pc_program = Factory(:pc_program)
      pc_program.reload
      pc_program.pc_unapproved_record.should_not be_nil
      record = pc_program.pc_unapproved_record
      # the approval process destroys the U record, for an edited record 
      pc_program.destroy
      PcUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      pc_program = Factory(:pc_program, :approval_status => 'U')
      pc_program.approve.should == ""
      pc_program.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      pc_program = Factory(:pc_program, :approval_status => 'A')
      pc_program2 = Factory(:pc_program, :approval_status => 'U', :approved_id => pc_program.id, :approved_version => 6)
      pc_program2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      pc_program1 = Factory(:pc_program, :approval_status => 'A')
      pc_program2 = Factory(:pc_program, :approval_status => 'U')
      pc_program1.enable_approve_button?.should == false
      pc_program2.enable_approve_button?.should == true
    end
  end

  context "options_for_pc_programs" do
    it "should return all approved pc_programs records" do
      pc_program1 = Factory(:pc_program, :code => "9967", :approval_status => 'A')
      pc_program2 = Factory(:pc_program, :code => "9968", :approval_status => 'A')
      pc_program3 = Factory(:pc_program, :code => "9969", :approval_status => 'A')
      pc_program4 = Factory(:pc_program, :code => "9970")
      expect(PcProgram.options_for_pc_programs).to eq([["9967", 1], ["9968", 2], ["9969", 3]])
    end
  end
end
