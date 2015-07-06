require 'spec_helper'

describe InwRemittanceRule do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context "validate_keywords" do 
    it "should validate keywords" do 
      rule = Factory.build(:inw_remittance_rule, :pattern_individuals => "1234 ese$sdgs", :pattern_corporates => "1234@,esesdgs", :pattern_beneficiaries => "1234 ese@sdgs", :pattern_remitters => "1234 ese$sdgs", :pattern_salutations => "1234@ esesdgs")
      rule.should_not be_valid
      rule.errors_on("pattern_individuals").should == ["is invalid"]
      rule.errors_on("pattern_corporates").should == ["is invalid"]
      rule.errors_on("pattern_beneficiaries").should == ["is invalid"]
      rule.errors_on("pattern_remitters").should == ["is invalid"]
      rule.errors_on("pattern_salutations").should == ["is invalid"]
      rule = Factory.build(:inw_remittance_rule, :pattern_individuals => "1234 esesdgs", :pattern_corporates => "1234 esesdgs", :pattern_beneficiaries => "1234 esesdgs", :pattern_remitters => "1234 esesdgs", :pattern_salutations => "1234 esesdgs")
      rule.should be_valid
      rule = Factory.build(:inw_remittance_rule, :pattern_individuals => "1234 ese sdgs", :pattern_corporates => "1234 ese-sdgs", :pattern_beneficiaries => "1234 (esesdgs)", :pattern_remitters => "1234 ese-sdgs", :pattern_salutations => "1234 e-(ses) dgs")
      rule.should be_valid
      rule = Factory.build(:inw_remittance_rule, :pattern_individuals => "  ", :pattern_corporates => " ", :pattern_beneficiaries => " ", :pattern_remitters => "  ", :pattern_salutations => "   ")
      rule.should be_valid
      rule.pattern_individuals.should == ""
      rule.pattern_corporates.should == ""
      rule.pattern_beneficiaries.should == ""
      rule.pattern_remitters.should == ""
      rule.pattern_salutations.should == ""
    end
  end
end
