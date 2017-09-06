require 'spec_helper'

describe SspBank do

  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end
  
  context "encrypt_password" do 
    it "should encrypt the http_password" do 
      ssp_bank = Factory.build(:ssp_bank, http_username: 'username', http_password: 'password')
      ssp_bank.save.should be_true
      ssp_bank.reload
      ssp_bank.http_password.should == "password"
    end
  end
  
  context "decrypt_password" do 
    it "should decrypt the http_password" do 
      ssp_bank = Factory(:ssp_bank, http_username: 'username', http_password: 'password')
      ssp_bank.http_password.should == "password"
    end
  end

  context "validation" do
    [:customer_code, :app_code, :is_enabled, :use_proxy].each do |att|
      it { should validate_presence_of(att) }
    end
    
    it "should validate presence of http_password if http_username is present" do
      ssp_bank = Factory.build(:ssp_bank, http_username: 'username', http_password: nil)
      ssp_bank.save.should == false
      ssp_bank.errors[:base].should == ["HTTP Password can't be blank if HTTP Username is present"]
    end

    it "should validate uniqueness of customer code with approval status a" do
      ssp_bank = Factory(:ssp_bank, approval_status: 'A')
      should validate_uniqueness_of(:customer_code).scoped_to(:approval_status, :app_code)
    end

    [:http_username, :debit_account_url, :reverse_debit_account_url, :get_status_url, :get_account_status_url].each do |att|
      it { should validate_length_of(att).is_at_most(100) }
    end
    
    it { should validate_length_of(:customer_code).is_at_most(15) }
    it { should validate_length_of(:app_code).is_at_most(50) }

    context "format" do
      context "debit_account_url, reverse_debit_account_url, get_status_url, get_account_status_url " do 
        it "should accept value matching the format" do
          [:debit_account_url, :reverse_debit_account_url, :get_status_url, :get_account_status_url].each do |att|
            should allow_value('http://localhost:3000/ssp_banks/1').for(att)
            should allow_value('https://google.com').for(att)
          end
        end

        it "should not accept value which does not match the format" do
          [:debit_account_url, :reverse_debit_account_url, :get_status_url, :get_account_status_url].each do |att|
            should_not allow_value('localhost@name').for(att)
            should_not allow_value('user@123*^').for(att)
          end
        end
      end
      
      context ":customer_code, :app_code" do
        it "should accept value matching the format" do
          [:customer_code, :app_code].each do |att|
            should allow_value('APP123').for(att)
            should allow_value('APP-23456').for(att)
          end
        end

        it "should not accept value which does not match the format" do
          [:customer_code, :app_code].each do |att|
            should_not allow_value('APP@123!').for(att)
            should_not allow_value('app~@123*^').for(att)
          end
        end
      end
    end
    
    context "set_settings_cnt" do
      it "should set counts of settings_count 1" do
        ecol_app = Factory(:ssp_bank, setting1_name: 'set1', setting1_type: 'number', setting1_value: '1')
        ecol_app.settings_cnt.should == 1
      end
      
      it "should set counts of settings_count 2" do
        ecol_app = Factory(:ssp_bank, setting1_name: 'set1', setting1_type: 'number', setting1_value: '1' , setting2_name: 'set1', setting2_type: 'number', setting2_value: '1')
        ecol_app.settings_cnt.should == 2
      end
      
      it "should set counts of settings_count 3" do
        ecol_app = Factory(:ssp_bank, setting1_name: 'set1', setting1_type: 'number', setting1_value: '1' ,
         setting2_name: 'set1', setting2_type: 'number', setting2_value: '1',
         setting3_name: 'set1', setting3_type: 'number', setting3_value: '1')
        ecol_app.settings_cnt.should == 3
      end
      
      it "should set counts of settings_count 4" do
        ecol_app = Factory(:ssp_bank, setting1_name: 'set1', setting1_type: 'number', setting1_value: '1' ,
         setting2_name: 'set1', setting2_type: 'number', setting2_value: '1',
         setting3_name: 'set1', setting3_type: 'number', setting3_value: '1',
         setting4_name: 'set1', setting4_type: 'number', setting4_value: '1')
        ecol_app.settings_cnt.should == 4
      end
      
      it "should set counts of settings_count 4" do
        ecol_app = Factory(:ssp_bank, setting1_name: 'set1', setting1_type: 'number', setting1_value: '1' ,
         setting2_name: 'set1', setting2_type: 'number', setting2_value: '1',
         setting3_name: 'set1', setting3_type: 'number', setting3_value: '1',
         setting4_name: 'set1', setting4_type: 'number', setting4_value: '1',
         setting5_name: 'set1', setting5_type: 'number', setting5_value: '1')
        ecol_app.settings_cnt.should == 5
      end
    end
    
    it "should validate presence of setting names" do
      ssp_bank = Factory.build(:ssp_bank, setting1_name: nil, setting2_name: 'setting2')
      ssp_bank.save.should == false
      ssp_bank.errors_on(:setting1_name).should == ["can't be blank when Setting2 name is present"]
      
      ssp_bank = Factory.build(:ssp_bank, setting2_name: nil, setting3_name: 'setting3')
      ssp_bank.save.should == false
      ssp_bank.errors_on(:setting2_name).should == ["can't be blank when Setting3 name is present"]
      
      ssp_bank = Factory.build(:ssp_bank, setting3_name: nil, setting4_name: 'setting4')
      ssp_bank.save.should == false
      ssp_bank.errors_on(:setting3_name).should == ["can't be blank when Setting4 name is present"]
      
      ssp_bank = Factory.build(:ssp_bank, setting4_name: nil, setting5_name: 'setting5')
      ssp_bank.save.should == false
      ssp_bank.errors_on(:setting4_name).should == ["can't be blank when Setting5 name is present"]
    end
    
    it "should validate the setting values" do
      ssp_bank = Factory.build(:ssp_bank, setting1_name: 'name1', setting1_type: 'text', setting1_value: nil)
      ssp_bank.save.should == false
      ssp_bank.errors_on(:setting1_value).should == ["can't be blank"]

      ssp_bank = Factory.build(:ssp_bank, setting1_name: 'name1', setting1_type: 'text', setting1_value: 'text')
      ssp_bank.save.should == true
      ssp_bank.errors_on(:setting1_value).should == []

      ssp_bank = Factory.build(:ssp_bank, setting1_name: 'name1', setting1_type: 'number', setting1_value: 'TEXT')
      ssp_bank.save.should == false
      ssp_bank.errors_on(:setting1_value).should == ["should include only digits"]

      ssp_bank = Factory.build(:ssp_bank, setting1_name: 'name1', setting1_type: 'number', setting1_value: '1234')
      ssp_bank.save.should == true
      ssp_bank.errors_on(:setting1_value).should == []

      ssp_bank = Factory.build(:ssp_bank, setting1_name: 'name1', setting1_type: 'text', setting1_value: 'yterqweytweuyqtweyqteyqtwerqwyertqweuryqwieuryqwerehquqwkjhequeuqeyuqjwhegruqywerqwjkeqjwehqjweqjhwegqhwe')
      ssp_bank.save.should == false
      ssp_bank.errors_on(:setting1_value).should == ["is longer than maximum (100)"]

      ssp_bank = Factory.build(:ssp_bank, setting1_name: 'name1', setting1_type: 'date', setting1_value: '2014:12:12')
      ssp_bank.save.should == false
      ssp_bank.errors_on(:setting1_value).should == ["invalid format, the correct format is yyyy-mm-dd", "is not a date"]

      ssp_bank = Factory.build(:ssp_bank, setting1_name: 'name1', setting1_type: 'date', setting1_value: '2016-12-12')
      ssp_bank.save.should == true
      ssp_bank.errors_on(:setting1_value).should == []
    end
  end

  context "default_scope" do 
    it "should only return 'A' records by default" do 
      ssp_bank1 = Factory(:ssp_bank, :approval_status => 'A') 
      ssp_bank2 = Factory(:ssp_bank)
      SspBank.all.should == [ssp_bank1]
      ssp_bank2.approval_status = 'A'
      ssp_bank2.save
      SspBank.all.should == [ssp_bank1,ssp_bank2]
    end
  end    

  context "unapproved_records" do 
    it "oncreate: should create unapproved_record if the approval_status is 'U'" do
      ssp_bank = Factory(:ssp_bank)
      ssp_bank.reload
      ssp_bank.unapproved_record_entry.should_not be_nil
    end

    it "oncreate: should not create unapproved_record if the approval_status is 'A'" do
      ssp_bank = Factory(:ssp_bank, :approval_status => 'A')
      ssp_bank.unapproved_record_entry.should be_nil
    end

    it "onupdate: should not remove unapproved_record if approval_status did not change from U to A" do
      ssp_bank = Factory(:ssp_bank)
      ssp_bank.reload
      ssp_bank.unapproved_record_entry.should_not be_nil
      record = ssp_bank.unapproved_record_entry
      # we are editing the U record, before it is approved
      ssp_bank.app_code = 'Foo123'
      ssp_bank.save
      ssp_bank.reload
      ssp_bank.unapproved_record_entry.should == record
    end

    it "onupdate: should remove unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      ssp_bank = Factory(:ssp_bank)
      ssp_bank.reload
      ssp_bank.unapproved_record_entry.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      ssp_bank.approval_status = 'A'
      ssp_bank.save
      ssp_bank.reload
      ssp_bank.unapproved_record_entry.should be_nil
    end

    it "ondestroy: should remove unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      ssp_bank = Factory(:ssp_bank)
      ssp_bank.reload
      ssp_bank.unapproved_record_entry.should_not be_nil
      record = ssp_bank.unapproved_record_entry
      # the approval process destroys the U record, for an edited record 
      ssp_bank.destroy
      UnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      ssp_bank = Factory(:ssp_bank, :approval_status => 'U')
      ssp_bank.approve.save.should == true
      ssp_bank.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      ssp_bank = Factory(:ssp_bank, :approval_status => 'A')
      ssp_bank1 = Factory(:ssp_bank, :approval_status => 'U', :approved_id => ssp_bank.id, :approved_version => 6)
      ssp_bank1.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      ssp_bank1 = Factory(:ssp_bank, :approval_status => 'A')
      ssp_bank2 = Factory(:ssp_bank, :approval_status => 'U')
      ssp_bank1.enable_approve_button?.should == false
      ssp_bank2.enable_approve_button?.should == true
    end
  end
end