require 'spec_helper'
describe EcolCustomer do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end
  
  context 'validation' do
    [:code, :name, :is_enabled, :val_method, :token_1_type, :token_1_length, :val_token_1, :token_2_type, :token_2_length, 
      :val_token_2, :token_3_type, :token_3_length, :val_token_3, :val_txn_date, :val_txn_amt, :val_ben_name, :val_rem_acct, 
      :return_if_val_fails, :credit_acct_no, :nrtv_sufx_1, :nrtv_sufx_2, :nrtv_sufx_3, :rmtr_alert_on].each do |att|
      it { should validate_presence_of(att) }
    end 
       
    it do 
      ecol_customer = Factory(:ecol_customer)
      should validate_uniqueness_of(:code)   
    end
    
    it do
      ecol_customer = Factory(:ecol_customer)
      [:code, :name].each do |att|
        should validate_length_of(att).is_at_least(1).is_at_most(15)
      end
      
      should validate_length_of(:credit_acct_no).is_at_least(1).is_at_most(25)
      
      [:rmtr_pass_txt, :rmtr_return_txt].each do |att|
        should validate_length_of(att).is_at_most(500)
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
      it { should validate_inclusion_of(att).in_array(['N', 'SC', 'RC', 'IN', 'RN', 'ORN', 'ORA']) }
    end
  end
  
  context "code format" do 
    it "should allow valid format" do
      should allow_value('CUST01').for(:code)
    end 
    
    it "should not allow invalid format" do
      should_not allow_value('@CUST01').for(:code)
      should_not allow_value('CUST01/').for(:code)
      should_not allow_value('CUST-01').for(:code)
    end     
  end
  
  context "field format" do 
    [:name, :credit_acct_no,:rmtr_pass_txt, :rmtr_return_txt].each do |att|
      it "should allow valid format" do
        should allow_value('ABCDCo').for(att)
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
    
    [
      %w( N I ),
      %w( N F ),
      %w( D P ),
      %w( W Q )
    ].each do |val_method, file_upld_mthd|
        it "does not allow the combination val_method=#{val_method} and file_upld_mthd=#{file_upld_mthd}" do
          ecol_customer = Factory.build(:ecol_customer, :file_upld_mthd => file_upld_mthd, :val_method => val_method)
          ecol_customer.save.should == false
        end
    end
        
    it "should check if val_tokens are N if val_method is N" do 
      ecol_customer = Factory.build(:ecol_customer, :val_method => "N", :val_token_1 => "Y", :val_token_2 => "Y", 
      :val_token_3 => "N", :val_txn_date => "N", :val_txn_amt => "Y")
      ecol_customer.save.should == false
      ecol_customer.errors[:base].should == ["If Validation Method is None, then all the Validation Account Tokens should also be N"]
    end
    
    it "should check if file_upld_mthd is present if val_method is D" do
      ecol_customer = Factory.build(:ecol_customer, :val_method => "D", :file_upld_mthd => nil)
      ecol_customer.save.should == false
      ecol_customer.errors_on(:file_upld_mthd).should == ["Can't be blank if Validation Method is Database Lookup"]

      ecol_customer = Factory.build(:ecol_customer, :val_method => "N", :file_upld_mthd => "F")
      ecol_customer.save.should == false
      ecol_customer.errors_on(:file_upld_mthd).should == ["Can't be selected as Validation Method is not Database Lookup"]
    end
    
    it "should check the value of all account tokens" do 
      ecol_customer = Factory.build(:ecol_customer, :token_1_type => "N", :token_2_type => "N", :token_3_type => "N")
      ecol_customer.save.should == false
      ecol_customer.errors[:base].should == ["Can't allow same value for all tokens"]
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
      EcolCustomer.options_for_file_upld_mthd.should == [['Full', 'F'],['Incremental','I']]
    end
    
    it "should return options for nrtv sufxs" do
      EcolCustomer.options_for_nrtv_sufxs.should == [['None','N'],['Sub Code','SC'],['Remitter Code','RC'],['Invoice Number','IN'],['Remitter Name','RN'],['Original Remitter Name','ORN'],['Original Remitter Account','ORA']]
    end
    
    it "should return options for rmtr alert on" do
      EcolCustomer.options_for_rmtr_alert_on == [['Never','N'],['On Pass','P'],['On Return','R'],['Always','A']]
    end
  end
  
end