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
      [:cod_acct_no, :stl_gl_inward, :stl_gl_return].each do |att|
        should_not allow_value('-1dfghhhhh').for(att)
        should_not allow_value('@acddsfdfd').for(att)
        should_not allow_value('134\ndsfdsg').for(att)
      end
    end
  end
  
  context "ifsc format" do 
    it "should allow valid format" do
      should allow_value('ABCD0QWERTY').for(:ifsc)
    end 
    
    it "should not allow invalid format" do
      should_not allow_value('abcd0QWERTY').for(:ifsc)
      should_not allow_value('abcdQWERTY').for(:ifsc)
      should_not allow_value('ab0QWER').for(:ifsc)
    end 
  end
end
