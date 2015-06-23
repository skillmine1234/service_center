require 'spec_helper'

describe EcolRemitter do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should belong_to(:ecol_customer) }
  end
  
  context 'validation' do
    [:customer_code, :remitter_code, :rmtr_name].each do |att|
      it { should validate_presence_of(att) }
    end
    
    [:invoice_amt, :invoice_amt_tol_pct, :min_credit_amt, :max_credit_amt, :due_date_tol_days].each do |att|
      it { should validate_numericality_of(att) }
    end

    it do 
      ecol_remitter = Factory(:ecol_remitter)
      should validate_uniqueness_of(:customer_code).scoped_to(:remitter_code, :customer_subcode, :invoice_no)  
      
      should validate_length_of(:credit_acct_no).is_at_most(15)   
    end
  end
  
  context 'fields format' do
    it 'should allow valid format' do
      [:customer_code, :customer_subcode, :remitter_code, :rmtr_acct_no, :invoice_no].each do |att|
        should allow_value('aaAAbbBB00').for(att)
        should allow_value('AAABBBC090').for(att)
        should allow_value('aaa0000bn').for(att)
        should allow_value('0123456789').for(att)
        should allow_value('AAAAAAAAAA').for(att)
      end
    end
    
    it 'should not allow invalid format' do
      ecol_remitter = Factory.build(:ecol_remitter, :customer_code => '-1dfghhhhh', :customer_subcode => '#$%jhdf', :remitter_code => '.09jnj823',
      :rmtr_acct_no => '134\ndsfdsg', :invoice_no => '&dbsdh^')
      ecol_remitter.save == false 
      [:customer_code, :customer_subcode, :remitter_code, :rmtr_acct_no, :invoice_no].each do |att|
        ecol_remitter.errors_on(att).should == ['Invalid format, expected format is : {[a-z|A-Z|0-9]}']
      end
    end
  end
  
  context "credit account no format" do 
    it "should allow valid format" do
      should allow_value('1234567890').for(:credit_acct_no)
    end 

    it "should not allow invalid format" do
      should_not allow_value('Absdjhsd').for(:credit_acct_no)
      should_not allow_value('@AbcCo').for(:credit_acct_no)
      should_not allow_value('/ab0QWER').for(:credit_acct_no)
    end 
  end
  
  context "check_email_address" do 
    it "should validate email address" do 
      ecol_remitter = Factory.build(:ecol_remitter, :customer_subcode_email => 'ASJD', :rmtr_email => '!d2@8765')
      ecol_remitter.should_not be_valid
      ecol_remitter.errors_on("customer_subcode_email").should == ["invalid email ASJD"]
      ecol_remitter.errors_on("rmtr_email").should == ["invalid email !d2@8765"]
      ecol_remitter = Factory.build(:ecol_remitter, :customer_subcode_email  => "foo@ruby.com", :rmtr_email => "foo@ruby.com")
      ecol_remitter.should be_valid
    end
  end
  
  context 'mobile number format' do
    it 'should allow valid format' do
      ecol_remitter = Factory.build(:ecol_remitter, :customer_subcode => '1213')
      [:customer_subcode_mobile, :rmtr_mobile].each do |att|
        ecol_remitter.should allow_value('9876543210').for(att)
      end
    end
    
    it 'should not allow invalid format' do
      ecol_remitter = Factory.build(:ecol_remitter, :customer_subcode_mobile => 'ASJD\98709', :rmtr_mobile => '-0!uhbd876')
      [:customer_subcode_mobile, :rmtr_mobile].each do |att|
        ecol_remitter.errors_on(att).should == ['Invalid format, expected format is : {[0-9]}']
      end
    end
  end
  
  context 'remitter name & address format' do
    it 'should allow valid format' do
      [:rmtr_name, :rmtr_address].each do |att|
        should allow_value('Abcd(09),op').for(att)
        should allow_value('Abcde:fgh').for(att)
        should allow_value('Abcd-op?').for(att)
        should allow_value('Abcd op jk').for(att)
      end
    end

    it 'should not allow invalid format' do
      ecol_remitter = Factory.build(:ecol_remitter, :rmtr_name => 'Anjkds**', :rmtr_address => '@ajdjh&NK#')
      ecol_remitter.save == false
      [:rmtr_name, :rmtr_address].each do |att|
        ecol_remitter.errors_on(att).should == ['Invalid format, expected format is : {[a-z|A-Z|0-9|\:|\/|\-|\?|\+|\(|\)|\.|\,\s]}']
      end
    end
  end
  
  context 'if_customer_subcode_is_nil' do
    it 'should perform validation if customer_subcode is nil' do
      ecol_remitter = Factory.build(:ecol_remitter, :customer_subcode => nil, :customer_subcode_mobile => '9876543210', :customer_subcode_email => 'a@b.com')
      ecol_remitter.save == false
      ecol_remitter.errors[:customer_subcode_email].should == ['should be empty when customer_subcode is empty']
      ecol_remitter.errors[:customer_subcode_mobile].should == ['should be empty when customer_subcode is empty']
    end
  end
  
  context "length" do
    it "should validate the length of the input if length constraint is present" do 
      udf_attribute = Factory(:udf_attribute, :attribute_name => 'udf4', :label_text => 'Udf4', :control_type => 'TextBox', :data_type => 'String', :length => 3, :is_enabled => 'Y')
      ecol_remitter = Factory.build(:ecol_remitter, :udf4 => '1234')
      ecol_remitter.should_not be_valid
      ecol_remitter.errors_on(:udf4).should == ["should be of 3 characters"]
      ecol_remitter = Factory.build(:ecol_remitter, :udf4 => ' ')
      ecol_remitter.errors_on(:udf4).should == []
    end
  end

  context "minimum length" do
    it "should validate the length of the input if minimum length constraint is present" do
      udf_attribute = Factory(:udf_attribute, :attribute_name => 'udf4', :label_text => 'Udf4', :control_type => 'TextBox', :data_type => 'String', :min_length => 3, :is_enabled => 'Y')
      ecol_remitter = Factory.build(:ecol_remitter, :udf4 => '12')
      ecol_remitter.should_not be_valid
      ecol_remitter.errors_on(:udf4).should == ["is too short (minimum is 3 characters)"]
      ecol_remitter = Factory.build(:ecol_remitter, :udf4 => ' ')
      ecol_remitter.errors_on(:udf4).should == []
    end
  end

  context "maximum length" do
    it "should validate the length of the input if maximum length constraint is present" do
      udf_attribute = Factory(:udf_attribute, :attribute_name => 'udf4', :label_text => 'Udf4', :control_type => 'TextBox', :data_type => 'String', :max_length => 3, :is_enabled => 'Y')
      ecol_remitter = Factory.build(:ecol_remitter, :udf4 => '12678')
      ecol_remitter.should_not be_valid
      ecol_remitter.errors_on(:udf4).should == ["is too long (maximum is 3 characters)"]
      ecol_remitter = Factory.build(:ecol_remitter, :udf4 => ' ')
      ecol_remitter.errors_on(:udf4).should == []
    end
  end

  context "minimum value" do
    it "should validate the value of the input if minimum value constraint is present" do
      udf_attribute = Factory(:udf_attribute, :attribute_name => 'udf4', :label_text => 'Udf4', :control_type => 'TextBox', :data_type => 'Numeric', :min_value => 30, :is_enabled => 'Y')
      ecol_remitter = Factory.build(:ecol_remitter, :udf4 => "20")
      ecol_remitter.should_not be_valid
      ecol_remitter.errors_on(:udf4).should == ["is less than 30"]
      ecol_remitter = Factory.build(:ecol_remitter, :udf4 => " ")
      ecol_remitter.errors_on(:udf4).should == []
    end
  end

  context "maximum value" do
    it "should validate the value of the input if maximum value constraint is present" do
      udf_attribute = Factory(:udf_attribute, :attribute_name => 'udf4', :label_text => 'Udf4', :control_type => 'TextBox', :data_type => 'Numeric', :max_value => 30, :is_enabled => 'Y')
      ecol_remitter = Factory.build(:ecol_remitter, :udf4 => "12678")
      ecol_remitter.should_not be_valid
      ecol_remitter.errors_on(:udf4).should == ["is more than 30"]
      ecol_remitter = Factory.build(:ecol_remitter, :udf4 => " ")
      ecol_remitter.errors_on(:udf4).should == []
    end
  end

  context "mandatory" do
    it "should validate the value of the input if maximum value constraint is present" do
      udf_attribute = Factory(:udf_attribute, :attribute_name => 'udf4', :label_text => 'Udf4', :control_type => 'TextBox', :data_type => 'Numeric', :is_mandatory => 'Y', :is_enabled => 'Y')
      ecol_remitter = Factory.build(:ecol_remitter, :udf4 => nil)
      ecol_remitter.should_not be_valid
      ecol_remitter.errors_on(:udf4).should == ["is required"]
    end
  end
  
  context "customer_code_should_exist" do
    it "should check if the customer code exists" do
      ecol_customer = Factory(:ecol_customer, :code => 'CUST00')
      ecol_remitter = Factory.build(:ecol_remitter, :customer_code => 'CUST00')
      ecol_remitter.save == true
      ecol_remitter = Factory.build(:ecol_remitter, :customer_code => 'CUST99')
      ecol_remitter.save == false
      ecol_remitter.errors_on(:customer_code) == ["Invalid Customer"]
    end
  end
  
end
