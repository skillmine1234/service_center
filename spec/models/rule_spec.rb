require 'spec_helper'

describe Rule do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context "format_fields" do 
    it "should format the fields" do 
      rule = Factory(:rule, :pattern_individuals => "1\r\n2", :pattern_corporates => "12\r\n5", :pattern_beneficiaries => "1\r\n2\r\n3")
      rule.format_fields
      rule.pattern_individuals.should == "1,2"
      rule.pattern_corporates.should == "12,5"
      rule.pattern_beneficiaries.should == "1,2,3"
    end
  end

  context "formated_pattern_individuals" do 
    it "should format pattern_individuals" do 
      rule = Factory.build(:rule, :pattern_individuals => "1,2")
      rule.formated_pattern_individuals.should == "1\r\n2"
    end
  end

  context "formated_pattern_corporates" do 
    it "should format pattern_corporates" do 
      rule = Factory.build(:rule, :pattern_corporates => "1,2")
      rule.formated_pattern_corporates.should == "1\r\n2"
    end
  end

  context "formated_pattern_beneficiaries" do 
    it "should format pattern_beneficiaries" do 
      rule = Factory.build(:rule, :pattern_beneficiaries => "1,2")
      rule.formated_pattern_beneficiaries.should == "1\r\n2"
    end
  end
end
