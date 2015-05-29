require 'spec_helper'

describe InwRemittanceRule do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context "format_fields" do 
    it "should format the fields" do 
      rule = Factory(:inw_remittance_rule, :pattern_individuals => "1\r\n2", :pattern_corporates => "12\r\n5", :pattern_beneficiaries => "1\r\n2\r\n3")
      rule.format_fields
      rule.pattern_individuals.should == "1,2"
      rule.pattern_corporates.should == "12,5"
      rule.pattern_beneficiaries.should == "1,2,3"
    end
  end

  context "formated_pattern_individuals" do 
    it "should format pattern_individuals" do 
      rule = Factory.build(:inw_remittance_rule, :pattern_individuals => "1,2")
      rule.formated_pattern_individuals.should == "1\r\n2"
    end
  end

  context "formated_pattern_corporates" do 
    it "should format pattern_corporates" do 
      rule = Factory.build(:inw_remittance_rule, :pattern_corporates => "1,2")
      rule.formated_pattern_corporates.should == "1\r\n2"
    end
  end

  context "formated_pattern_beneficiaries" do 
    it "should format pattern_beneficiaries" do 
      rule = Factory.build(:inw_remittance_rule, :pattern_beneficiaries => "1,2")
      rule.formated_pattern_beneficiaries.should == "1\r\n2"
    end
  end

  context "formated_pattern_salutations" do 
    it "should format formated_pattern_salutations" do 
      rule = Factory.build(:inw_remittance_rule, :pattern_salutations => "1,2")
      rule.formated_pattern_salutations.should == "1\r\n2"
    end
  end

  context "validate_keywords" do 
    it "should validate keywords" do 
      rule = Factory.build(:inw_remittance_rule, :pattern_individuals => "1234,ese sdgs", :pattern_corporates => "1234@,esesdgs", :pattern_beneficiaries => "1234,ese sdgs", :pattern_salutations => "1234@,esesdgs")
      rule.should_not be_valid
      rule.errors_on("pattern_individuals").should == ["are invalid due to ese sdgs"]
      rule.errors_on("pattern_corporates").should == ["are invalid due to 1234@"]
      rule.errors_on("pattern_beneficiaries").should == ["are invalid due to ese sdgs"]
      rule.errors_on("pattern_salutations").should == ["are invalid due to 1234@"]
      rule = Factory.build(:inw_remittance_rule, :pattern_individuals => "1234,esesdgs", :pattern_corporates => "1234,esesdgs", :pattern_beneficiaries => "1234,esesdgs", :pattern_salutations => "1234,esesdgs")
      rule.should be_valid
    end
  end
end
