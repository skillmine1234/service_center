require 'spec_helper'
describe EcolCustomer do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:ecol_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end
  
  context 'validation' do
    [:code, :name, :is_enabled, :val_method, :token_1_type, :token_1_length, :val_token_1, :token_2_type, :token_2_length, 
      :val_token_2, :token_3_type, :token_3_length, :val_token_3, :val_txn_date, :val_txn_amt, :val_ben_name, :val_rem_acct, 
      :return_if_val_fails, :nrtv_sufx_1, :nrtv_sufx_2, :nrtv_sufx_3, :rmtr_alert_on, :credit_acct_val_pass, :credit_acct_val_fail].each do |att|
      it { should validate_presence_of(att) }
    end 
       
    it do 
      ecol_customer = Factory(:ecol_customer, :approval_status => 'A')
      should validate_uniqueness_of(:code).scoped_to(:approval_status)   
    end
    
    it do
      ecol_customer = Factory(:ecol_customer)
      should validate_length_of(:code).is_at_least(1).is_at_most(15)
      
      should validate_length_of(:name).is_at_least(5).is_at_most(50)
      
      should validate_length_of(:credit_acct_val_pass).is_at_least(10).is_at_most(25)
      should validate_length_of(:credit_acct_val_fail).is_at_least(10).is_at_most(25)
      
      [:rmtr_pass_txt, :rmtr_return_txt].each do |att|
        should validate_length_of(att).is_at_most(500)
      end
    end
    
    it do
      ecol_customer = Factory(:ecol_customer)
      [:token_1_length, :token_2_length, :token_3_length].each do |att|
        should validate_numericality_of(att)
      end
    end
    
    it do
      ecol_customer = Factory(:ecol_customer)
      should validate_inclusion_of(:val_method).in_array(['N', 'W', 'D'])
      should validate_inclusion_of(:rmtr_alert_on).in_array(['N', 'P', 'R', 'A'])
    end
    [:token_1_type, :token_2_type, :token_3_type].each do |att|
      it { should validate_inclusion_of(att).in_array(['N', 'SC', 'RC', 'IN']) }
    end
    [:nrtv_sufx_1, :nrtv_sufx_2, :nrtv_sufx_3].each do |att|
      it { should validate_inclusion_of(att).in_array(['N', 'SC', 'RC', 'IN', 'RN', 'ORN', 'ORA', 'TUN', 'UDF1', 'UDF2']) }
    end

    it "should validate_unapproved_record" do 
      ecol_customer1 = Factory(:ecol_customer,:approval_status => 'A')
      ecol_customer2 = Factory(:ecol_customer, :approved_id => ecol_customer1.id)
      ecol_customer1.should_not be_valid
      ecol_customer1.errors_on(:base).should == ["Unapproved Record Already Exists for this record"]
    end
  end
  
  context "code format" do 
    it "should allow valid format" do
      should allow_value('9876').for(:code)
      should allow_value('ABCD90').for(:code)
    end 
    
    it "should not allow invalid format" do
      should_not allow_value('@CUST01').for(:code)
      should_not allow_value('CUST01/').for(:code)
      should_not allow_value('CUST-01').for(:code)
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
  
  context "account no format" do 
    [:credit_acct_val_pass, :credit_acct_val_fail].each do |att|
      it "should allow valid format" do
        should allow_value('1234567890').for(att)
      end

      it "should not allow invalid format" do
        should_not allow_value('Absdjhsd').for(att)
        should_not allow_value('@AbcCo').for(att)
        should_not allow_value('/ab0QWER').for(att)
      end
    end 
  end
  
  context "sms text format" do 
    [:rmtr_pass_txt, :rmtr_return_txt].each do |att|
      it "should allow valid format" do
        should allow_value('ABCDCo').for(att)
        should allow_value('ABCD.Co').for(att)
        should allow_value('ABCD, Co').for(att)
      end 
  
      it "should not allow invalid format" do
        should_not allow_value('@AbcCo').for(att)
        should_not allow_value('/ab0QWER').for(att)
      end 
    end
  end
  
  context "cross-field validations" do 

    [
      %w( D F ),
      %w( D I )
    ].each do |val_method, file_upld_mthd|
        it "allows the combination val_method=#{val_method} and file_upld_mthd=#{file_upld_mthd}" do
          ecol_customer = Factory.build(:ecol_customer, :file_upld_mthd => file_upld_mthd, :val_method => val_method)
          ecol_customer.save.should == true
        end
      end
    
    it "should check if file_upld_mthd is present if val_method is D" do
      ecol_customer = Factory.build(:ecol_customer, :val_method => "D", :file_upld_mthd => nil)
      ecol_customer.save.should == false
      ecol_customer.errors_on(:file_upld_mthd).should == ["Can't be blank or None if Validation Method is Database Lookup"]
    end
    
    it "should check the value of all account tokens" do 
      ecol_customer = Factory.build(:ecol_customer, :token_1_type => "SC", :token_1_length => 1, :token_2_type => "SC", :token_2_length => 1, :token_3_type => "SC", :token_3_length => 1)
      ecol_customer.save.should == false
      ecol_customer.errors[:base].should == ["Can't allow same value for all tokens except for 'None'"]
      
      ecol_customer = Factory.build(:ecol_customer, :token_1_type => "N", :token_2_type => "N", :token_3_type => "N")
      ecol_customer.save.should == true
      ecol_customer.errors[:base].should == []
    end
    
    it "should check the value of acct token 2 & 3 if acct token 1 is N" do
      ecol_customer = Factory.build(:ecol_customer, :token_1_type => "N", :token_2_type => "SC", :token_2_length => 1, :token_3_type => "IN", :token_3_length => 1)
      ecol_customer.save.should == false
      ecol_customer.errors[:base].should == ["If Account Token 1 is None, then Account Token 2 & Account Token 3 should also be None"]
    end
    
    it "should check the value of acct token 3 if acct token 2 is N" do
      ecol_customer = Factory.build(:ecol_customer, :token_1_type => "IN", :token_1_length => 1, :token_2_type => "N", :token_3_type => "SC", :token_3_length => 1)
      ecol_customer.save.should == false
      ecol_customer.errors[:base].should == ["If Account Token 2 is None, then Account Token 3 also should be None"]
    end
    
    it "should check the value of all narration suffixes" do
      ecol_customer = Factory.build(:ecol_customer, :nrtv_sufx_1 => "RC", :nrtv_sufx_2 => "RC", :nrtv_sufx_3 => "RC")
      ecol_customer.save.should == false
      ecol_customer.errors[:base].should == ["Can't allow same value for all narration suffixes except for 'None'"]
      
      ecol_customer = Factory.build(:ecol_customer, :nrtv_sufx_1 => "N", :nrtv_sufx_2 => "N", :nrtv_sufx_3 => "N")
      ecol_customer.save.should == true
      ecol_customer.errors[:base].should == []
    end
      
    it "should check presence of rmtr_pass_txt if rmtr_alert_on is P or A" do
      ecol_customer = Factory.build(:ecol_customer, :rmtr_alert_on => "P", :rmtr_pass_txt => nil)
      ecol_customer.save.should == false
      ecol_customer.errors_on(:rmtr_pass_txt).should == ["Can't be blank if Send Alerts To Remitter On is On Pass or Always"]
    end
    
    it "should check presence of rmtr_return_txt if rmtr_alert_on is R or A" do  
      ecol_customer = Factory.build(:ecol_customer, :rmtr_alert_on => "R", :rmtr_return_txt => nil)
      ecol_customer.save.should == false
      ecol_customer.errors_on(:rmtr_return_txt).should == ["Can't be blank if Send Alerts To Remitter On is On Return or Always"]
    end
    
    it "should check values of nrtx_sufxs 2 & 3 if nrtv_sufx_1 is N" do
      ecol_customer = Factory.build(:ecol_customer, :nrtv_sufx_1 => "N", :nrtv_sufx_2 => "SC", :nrtv_sufx_3 => "RC")
      ecol_customer.save.should == false
      ecol_customer.errors[:base].should == ["If Narrative Suffix 1 is None, then Narrative Suffix 2 & Narrative Suffix 3 should also be None"]
    end
      
    it "should check value of nrtv_sufx_3 is nrtv_sufx_1 is N" do  
      ecol_customer = Factory.build(:ecol_customer, :nrtv_sufx_1 => "RC", :nrtv_sufx_2 => "N", :nrtv_sufx_3 => "SC")
      ecol_customer.save.should == false
      ecol_customer.errors[:base].should == ["If Narrative Suffix 2 is None, then Narrative Suffix 3 also should be None"]
    end
  end
  
  context "options_for_select_boxes" do
    it "should return options for val method" do
      EcolCustomer.options_for_val_method.should == [['None','N'],['Web Service','W'],['Database Lookup','D']]
    end
    
    it "should return options for acct tokens" do
      EcolCustomer.options_for_acct_tokens.should == [['None','N'],['Sub Code','SC'],['Remitter Code','RC'],['Invoice Number','IN']]
    end
    
    it "should return options for file upld mthd" do
      EcolCustomer.options_for_file_upld_mthd.should == [['None','N'],['Full', 'F'],['Incremental','I']]
    end
    
    it "should return options for nrtv sufxs" do
      EcolCustomer.options_for_nrtv_sufxs.should == [['None','N'],['Sub Code','SC'],['Remitter Code','RC'],['Invoice Number','IN'],['Remitter Name','RN'],['Original Remitter Name','ORN'],['Original Remitter Account','ORA'],['Transfer Unique No','TUN'],['User Defined Field 1','UDF1'],['User Defined Field 2','UDF2']]
    end
    
    it "should return options for rmtr alert on" do
      EcolCustomer.options_for_rmtr_alert_on == [['Never','N'],['On Pass','P'],['On Return','R'],['Always','A']]
    end

    it "should return options for val txn date" do
      EcolCustomer.options_for_val_txn_amt == [['None','N'],['Exact','E'],['Range','R']]
    end
    
    it "should return options for val txn amt" do
      EcolCustomer.options_for_val_txn_amt == [['None','N'],['Exact','E'],['Range','R'],['Percentage','P']]
    end
  end
  
  context "customer_code_format" do
    it "should validate customer code format" do
      ecol_customer = Factory.build(:ecol_customer, :code => '9876')
      ecol_customer.save.should == true
      
      ecol_customer = Factory.build(:ecol_customer, :code => '876098')
      ecol_customer.save.should == true
      
      ecol_customer = Factory.build(:ecol_customer, :code => 'abcdef')
      ecol_customer.save.should == true
      
      ecol_customer = Factory.build(:ecol_customer, :code => '98760988767')
      ecol_customer.save.should == false
      ecol_customer.errors_on(:code).should == ["the code can be either a 4 digit number starting with 9, or a 6 character alpha-numeric code, that does not start with 9"]
    end
  end

  context "account_token_types" do
    it "returns an array of account tokens" do 
      ecol_customer = Factory(:ecol_customer)
      ecol_customer.account_token_types.should == [ecol_customer.token_1_type, ecol_customer.token_2_type, ecol_customer.token_3_type]
    end
  end
  
  context "validate_account_token_length" do
    it "should validate length of account tokens" do
      ecol_customer = Factory.build(:ecol_customer, :token_1_type => 'SC', :token_1_length => 1)
      ecol_customer.save == true
      ecol_customer = Factory.build(:ecol_customer, :token_1_type => 'SC', :token_1_length => 0)
      ecol_customer.save == false
      ecol_customer = Factory.build(:ecol_customer, :token_1_type => 'N', :token_1_length => 0)
      ecol_customer.save == true    
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      ecol_customer1 = Factory(:ecol_customer, :approval_status => 'A') 
      ecol_customer2 = Factory(:ecol_customer)
      EcolCustomer.all.should == [ecol_customer1]
      ecol_customer2.approval_status = 'A'
      ecol_customer2.save
      EcolCustomer.all.should == [ecol_customer1,ecol_customer2]
    end
  end    

  context "create_ecol_unapproved_records" do 
    it "should create ecol_unapproved_record if the approval_status is 'U' and there is no previous record" do
      ecol_customer = Factory(:ecol_customer)
      ecol_customer.reload
      ecol_customer.ecol_unapproved_record.should_not be_nil
      record = ecol_customer.ecol_unapproved_record
      ecol_customer.name = 'Foo'
      ecol_customer.save
      ecol_customer.ecol_unapproved_record.should == record
    end

    it "should not create ecol_unapproved_record if the approval_status is 'A'" do
      ecol_customer = Factory(:ecol_customer, :approval_status => 'A')
      ecol_customer.ecol_unapproved_record.should be_nil
    end
  end  

  context "remove_ecol_unapproved_records" do 
    it "should remove ecol_unapproved_record if the approval_status is 'A' and there is unapproved_record" do
      ecol_customer = Factory(:ecol_customer)
      ecol_customer.reload
      ecol_customer.ecol_unapproved_record.should_not be_nil
      record = ecol_customer.ecol_unapproved_record
      ecol_customer.name = 'Foo'
      ecol_customer.save
      ecol_customer.ecol_unapproved_record.should == record
      ecol_customer.approval_status = 'A'
      ecol_customer.save
      ecol_customer.remove_ecol_unapproved_records
      ecol_customer.reload
      ecol_customer.ecol_unapproved_record.should be_nil
    end
  end  

  context "approve" do 
    it "should approve unapproved_record" do 
      ecol_customer = Factory(:ecol_customer, :approval_status => 'U')
      ecol_customer.approve.should == ""
      ecol_customer.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      ecol_customer = Factory(:ecol_customer, :approval_status => 'A')
      ecol_customer2 = Factory(:ecol_customer, :approval_status => 'U', :approved_id => ecol_customer.id, :approved_version => 6)
      ecol_customer2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      ecol_customer1 = Factory(:ecol_customer, :approval_status => 'A')
      ecol_customer2 = Factory(:ecol_customer, :approval_status => 'U')
      ecol_customer1.enable_approve_button?.should == false
      ecol_customer2.enable_approve_button?.should == true
    end
  end
  
  context "value_of_validation_fields" do
    it "should validate value of validate fields" do
      ecol_customer = Factory.build(:ecol_customer, :approval_status => 'A', :val_method => 'W', :val_token_1 => 'N', :val_token_2 => 'N', :val_token_3 => 'N', 
      :val_txn_date => 'Y', :val_txn_amt => 'Y', :val_rem_acct => 'Y')
      ecol_customer.save.should == false
      ecol_customer.errors[:base].should == ["Transaction Date, Transaction Amount and Remitter Account cannot be validated as no Token is validated"]
    end
  end
  
  context "set_validation_fields_to_N" do
    it "should set validation fields to N" do
      ecol_customer = Factory.build(:ecol_customer, :approval_status => 'A', :val_method => 'N', :val_token_1 => 'Y')
      ecol_customer.save
      ecol_customer.val_token_1.should == 'N'
      ecol_customer.val_token_2.should == 'N'
      ecol_customer.val_token_3.should == 'N'
      ecol_customer.val_txn_date.should == 'N'
      ecol_customer.val_txn_amt.should == 'N'
      ecol_customer.val_ben_name.should == 'N'
      ecol_customer.val_rem_acct.should == 'N'
      ecol_customer.return_if_val_fails.should == 'N'
      ecol_customer.file_upld_mthd.should == 'N'   
    end
  end
end
