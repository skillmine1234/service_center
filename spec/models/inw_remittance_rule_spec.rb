require 'spec_helper'

describe InwRemittanceRule do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:inw_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
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
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      rule1 = Factory(:inw_remittance_rule, :approval_status => 'A') 
      rule2 = Factory(:inw_remittance_rule)
      InwRemittanceRule.all.should == [rule1]
      rule2.approval_status = 'A'
      rule2.save
      InwRemittanceRule.all.should == [rule1,rule2]
    end
  end  
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      inw_rule1 = Factory(:inw_remittance_rule, :approval_status => 'A') 
      inw_rule2 = Factory(:inw_remittance_rule)
      InwRemittanceRule.all.should == [inw_rule1]
      inw_rule2.approval_status = 'A'
      inw_rule2.save
      InwRemittanceRule.all.should == [inw_rule1,inw_rule2]
    end
  end    

  context "create_inw_unapproved_records" do 
    it "should create inw_unapproved_record if the approval_status is 'U' and there is no previous record" do
      inw_rule = Factory(:inw_remittance_rule)
      inw_rule.reload
      inw_rule.inw_unapproved_record.should_not be_nil
      record = inw_rule.inw_unapproved_record
      inw_rule.save
      inw_rule.inw_unapproved_record.should == record
    end

    it "should not create ecol_unapproved_record if the approval_status is 'A'" do
      inw_rule = Factory(:inw_remittance_rule, :approval_status => 'A')
      inw_rule.inw_unapproved_record.should be_nil
    end
  end  

  context "remove_inw_unapproved_records" do 
    it "should remove inw_unapproved_record if the approval_status is 'A' and there is unapproved_record" do
      inw_rule = Factory(:inw_remittance_rule)
      inw_rule.reload
      inw_rule.inw_unapproved_record.should_not be_nil
      record = inw_rule.inw_unapproved_record
      inw_rule.save
      inw_rule.inw_unapproved_record.should == record
      inw_rule.approval_status = 'A'
      inw_rule.save
      inw_rule.remove_inw_unapproved_records
      inw_rule.reload
      inw_rule.inw_unapproved_record.should be_nil
    end
  end  

  context "approve" do 
    it "should approve unapproved_record" do 
      inw_rule = Factory(:inw_remittance_rule, :approval_status => 'U')
      inw_rule.approve.should == ""
      inw_rule.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      inw_rule = Factory(:inw_remittance_rule, :approval_status => 'A')
      inw_rule2 = Factory(:inw_remittance_rule, :approval_status => 'U', :approved_id => inw_rule.id, :approved_version => 6)
      inw_rule2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      inw_rule1 = Factory(:inw_remittance_rule, :approval_status => 'A')
      inw_rule2 = Factory(:inw_remittance_rule, :approval_status => 'U')
      inw_rule1.enable_approve_button?.should == false
      inw_rule2.enable_approve_button?.should == true
    end
  end
end