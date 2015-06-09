require 'spec_helper'

describe EcolRule do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end
  
  context 'validation' do
    [:ifsc, :cod_acct_no, :stl_gl_inward, :stl_gl_return].each do |att|
      it { should validate_presence_of(att) }
    end
  end
  
  context "fields format" do
    it "should allow valid format" do 
      [:cod_acct_no, :stl_gl_inward, :stl_gl_return].each do |att|
        should allow_value('aaAAbbBB00').for(att)
        should allow_value('AAABBBC090').for(att)
        should allow_value('aaa0000bn').for(att)
        should allow_value('0123456789').for(att)
        should allow_value('AAAAAAAAAA').for(att)
      end
    end

    it "should not allow invalid format" do 
      ecol_rule = Factory.build(:ecol_rule, :cod_acct_no => '-1dfghhhhh', :stl_gl_inward => '@acddsfdfd', :stl_gl_return => '134\ndsfdsg')
      ecol_rule.save == false
      [:cod_acct_no, :stl_gl_inward, :stl_gl_return].each do |att|
        ecol_rule.errors_on(att).should == ["Invalid format, expected format is : {[a-z|A-Z|0-9]}"]
      end
    end
  end
  
  context "ifsc format" do 
    it "should allow valid format" do
      should allow_value('ABCD0QWERTY').for(:ifsc)
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
end
