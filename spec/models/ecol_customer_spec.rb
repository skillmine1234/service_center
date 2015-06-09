require 'spec_helper'
describe EcolCustomer do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end
  
  context 'validation' do
    [:code, :name, :val_method, :token_1_type, :token_1_length, :token_2_type, :token_2_length, :token_3_type, :token_3_length, 
      :credit_acct_no, :nrtv_sufx_1, :nrtv_sufx_2, :nrtv_sufx_3, :rmtr_alert_on].each do |att|
      it { should validate_presence_of(att) }
    end    
    it do 
      ecol_customer = Factory(:ecol_customer)
      should validate_uniqueness_of(:code)   
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
    [:name, :credit_acct_no].each do |att|
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
    it "should do cross-field validations" do 
      ecol_customer = Factory.build(:ecol_customer, :val_method => "N", :val_token_1 => "Y", :val_token_2 => "Y", 
      :val_token_3 => "N", :val_txn_date => "N", :val_txn_amt => "Y")
      ecol_customer.save.should == false
      ecol_customer.errors[:base].should == ["If Validation Method is None, then all the Validation Account Tokens should also be None"]
  
      ecol_customer = Factory.build(:ecol_customer, :val_method => "D", :file_upld_mthd => nil)
      ecol_customer.save.should == false
      ecol_customer.errors_on(:file_upld_mthd).should == ["Can't be blank if Validation Method is Database Lookup"]
      
      ecol_customer = Factory.build(:ecol_customer, :token_1_type => "N", :token_2_type => "N", :token_3_type => "N")
      ecol_customer.save.should == false
      ecol_customer.errors[:base].should == ["Can't allow same value for all tokens"]
      
      ecol_customer = Factory.build(:ecol_customer, :nrtv_sufx_1 => "RC", :nrtv_sufx_2 => "RC", :nrtv_sufx_3 => "RC")
      ecol_customer.save.should == false
      ecol_customer.errors[:base].should == ["Can't allow same value for all narration suffixes"]
      
      ecol_customer = Factory.build(:ecol_customer, :nrtv_sufx_1 => "N", :nrtv_sufx_2 => "N", :nrtv_sufx_3 => "N")
      ecol_customer.save.should == true
      ecol_customer.errors[:base].should == []
      
      ecol_customer = Factory.build(:ecol_customer, :rmtr_alert_on => "P", :rmtr_pass_txt => "")
      ecol_customer.save.should == false
      ecol_customer.errors_on(:rmtr_pass_txt).should == ["Can't be blank if Send Alerts To Remitter On is On Pass or Always"]
      
      ecol_customer = Factory.build(:ecol_customer, :rmtr_alert_on => "R", :rmtr_return_txt => "")
      ecol_customer.save.should == false
      ecol_customer.errors_on(:rmtr_return_txt).should == ["Can't be blank if Send Alerts To Remitter On is On Return or Always"]
      
      ecol_customer = Factory.build(:ecol_customer, :nrtv_sufx_1 => "N", :nrtv_sufx_2 => "SC", :nrtv_sufx_3 => "RC")
      ecol_customer.save.should == false
      ecol_customer.errors[:base].should == ["If Narrative Suffix 1 is None, then Narrative Suffix 2 & Narrative Suffix 3 should also be None"]
      
      ecol_customer = Factory.build(:ecol_customer, :nrtv_sufx_1 => "RC", :nrtv_sufx_2 => "N", :nrtv_sufx_3 => "SC")
      ecol_customer.save.should == false
      ecol_customer.errors[:base].should == ["If Narrative Suffix 2 is None, then Narrative Suffix 3 also should be None"]
    end
  end
end
