require 'spec_helper'

describe EcolRule do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:ecol_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end
  
  context 'validation' do
    [:ifsc, :cod_acct_no, :stl_gl_inward, :stl_gl_return, :neft_sender_ifsc, :cbs_userid].each do |att|
      it { should validate_presence_of(att) }
    end
    
    it "should validate_unapproved_record" do 
      ecol_rule1 = Factory(:ecol_rule,:approval_status => 'A')
      ecol_rule2 = Factory(:ecol_rule, :approved_id => ecol_rule1.id)
      ecol_rule1.should_not be_valid
      ecol_rule1.errors_on(:base).should == ["Unapproved Record Already Exists for this record"]
    end
  end
  
  context "fields format" do
    it "should allow valid format" do 
      [:cod_acct_no, :stl_gl_inward, :stl_gl_return, :cbs_userid].each do |att|
        should allow_value('aaAAbbBB00').for(att)
        should allow_value('AAABBBC090').for(att)
        should allow_value('aaa0000bn').for(att)
        should allow_value('0123456789').for(att)
        should allow_value('AAAAAAAAAA').for(att)
      end
    end

    it "should not allow invalid format" do 
      ecol_rule = Factory.build(:ecol_rule, :cod_acct_no => '-1dfghhhhh', :stl_gl_inward => '@acddsfdfd', :stl_gl_return => '134\ndsfdsg', 
      :cbs_userid => '@,.9023jsf')
      ecol_rule.save == false
      [:cod_acct_no, :stl_gl_inward, :stl_gl_return, :cbs_userid].each do |att|
        ecol_rule.errors_on(att).should == ["Invalid format, expected format is : {[a-z|A-Z|0-9]}"]
      end
    end
  end
  
  context "ifsc format" do 
    [:ifsc, :neft_sender_ifsc].each do |att|
      it "should allow valid format" do
        should allow_value('ABCD0QWERTY').for(att)
      end 
    end
    
    it "should not allow invalid format" do
      ecol_rule = Factory.build(:ecol_rule, :ifsc => 'abcd0QWERTY')
      ecol_rule.errors_on(:ifsc).should == ["Invalid format, expected format is : {[A-Z]{4}[0][A-Z|0-9]{6}}"]
      ecol_rule = Factory.build(:ecol_rule, :ifsc => 'abcdQWERTY')
      ecol_rule.errors_on(:ifsc).should == ["Invalid format, expected format is : {[A-Z]{4}[0][A-Z|0-9]{6}}"]
      ecol_rule = Factory.build(:ecol_rule, :ifsc => 'ab0QWER')
      ecol_rule.errors_on(:ifsc).should == ["Invalid format, expected format is : {[A-Z]{4}[0][A-Z|0-9]{6}}"]
    end 
  end

  context "default_scope" do 
    it "should only return 'A' records by default" do 
      ecol_rule1 = Factory(:ecol_rule, :approval_status => 'A') 
      ecol_rule2 = Factory(:ecol_rule)
      EcolRule.all.should == [ecol_rule1]
      ecol_rule2.approval_status = 'A'
      ecol_rule2.save
      EcolRule.all.should == [ecol_rule1,ecol_rule2]
    end
  end    

  context "create_ecol_unapproved_records" do 
    it "should create ecol_unapproved_record if the approval_status is 'U' and there is no previous record" do
      ecol_rule = Factory(:ecol_rule)
      ecol_rule.reload
      ecol_rule.ecol_unapproved_record.should_not be_nil
      record = ecol_rule.ecol_unapproved_record
      ecol_rule.save
      ecol_rule.ecol_unapproved_record.should == record
    end

    it "should not create ecol_unapproved_record if the approval_status is 'A'" do
      ecol_rule = Factory(:ecol_rule, :approval_status => 'A')
      ecol_rule.ecol_unapproved_record.should be_nil
    end
  end  

  context "remove_ecol_unapproved_records" do 
    it "should remove ecol_unapproved_record if the approval_status is 'A' and there is unapproved_record" do
      ecol_rule = Factory(:ecol_rule)
      ecol_rule.reload
      ecol_rule.ecol_unapproved_record.should_not be_nil
      record = ecol_rule.ecol_unapproved_record
      ecol_rule.save
      ecol_rule.ecol_unapproved_record.should == record
      ecol_rule.approval_status = 'A'
      ecol_rule.save
      ecol_rule.remove_ecol_unapproved_records
      ecol_rule.reload
      ecol_rule.ecol_unapproved_record.should be_nil
    end
  end  

  context "approve" do 
    it "should approve unapproved_record" do 
      ecol_rule = Factory(:ecol_rule, :approval_status => 'U')
      ecol_rule.approve.should == ""
      ecol_rule.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      ecol_rule = Factory(:ecol_rule, :approval_status => 'A')
      ecol_rule2 = Factory(:ecol_rule, :approval_status => 'U', :approved_id => ecol_rule.id, :approved_version => 6)
      ecol_rule2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      ecol_rule1 = Factory(:ecol_rule, :approval_status => 'A')
      ecol_rule2 = Factory(:ecol_rule, :approval_status => 'U')
      ecol_rule1.enable_approve_button?.should == false
      ecol_rule2.enable_approve_button?.should == true
    end
  end
end
