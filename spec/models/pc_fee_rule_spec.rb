require 'spec_helper'

describe PcFeeRule do
  context "association" do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should belong_to(:pc_app) }
  end
  
  context "validation" do
    [:app_id, :txn_kind, :no_of_tiers].each do |att|
      it { should validate_presence_of(att) }
    end
    
    it do 
      pc_fee_rule = Factory(:pc_fee_rule, :approval_status => 'A')
      should validate_uniqueness_of(:app_id).scoped_to(:txn_kind, :approval_status)
    end
    
    # [:tier1_to_amt, :tier1_fixed_amt, :tier1_min_sc_amt, :tier1_max_sc_amt, :tier2_to_amt,
    #   :tier2_fixed_amt, :tier2_min_sc_amt, :tier2_max_sc_amt, :tier3_fixed_amt, :tier3_min_sc_amt,
    #   :tier3_max_sc_amt, :tier1_pct_value, :tier2_pct_value, :tier3_pct_value, :no_of_tiers].each do |att|
    #   it {should validate_numericality_of(att)}
    # end
  end
  
  context "options_for_txn_kind" do
    it "should return options for txn_kind" do
      PcFeeRule.options_for_txn_kind.should == [['loadCard','LC'],['payToAccount','PA'],['payToContact','PC'],['topUp','TU']]
    end
  end
  
  context "options_for_tier_method" do
    it "should return options for tier method" do
      PcFeeRule.options_for_tier_method.should == [['Fixed','F'],['Percentage','P']]
    end
  end
  
  context "app_id_should_exist" do
    it "should check existence of app_id" do
      pc_fee_rule = Factory.build(:pc_fee_rule, :app_id => "1234")
      pc_fee_rule.save.should == false
      pc_fee_rule.errors_on(:app_id).should == ["Invalid PcApp"]
    end
  end
  
  context "default_scope" do 
    it "should only return 'A' records by default" do 
      pc_fee_rule1 = Factory(:pc_fee_rule, :approval_status => 'A') 
      pc_fee_rule2 = Factory(:pc_fee_rule)
      PcFeeRule.all.should == [pc_fee_rule1]
      pc_fee_rule2.approval_status = 'A'
      pc_fee_rule2.save
      PcFeeRule.all.should == [pc_fee_rule1,pc_fee_rule2]
    end
  end    

  context "pc_unapproved_records" do 
    it "oncreate: should create pc_unapproved_record if the approval_status is 'U'" do
      pc_fee_rule = Factory(:pc_fee_rule)
      pc_fee_rule.reload
      pc_fee_rule.pc_unapproved_record.should_not be_nil
    end

    it "oncreate: should not create pc_unapproved_record if the approval_status is 'A'" do
      pc_fee_rule = Factory(:pc_fee_rule, :approval_status => 'A')
      pc_fee_rule.pc_unapproved_record.should be_nil
    end

    it "onupdate: should not remove pc_unapproved_record if approval_status did not change from U to A" do
      pc_fee_rule = Factory(:pc_fee_rule)
      pc_fee_rule.reload
      pc_fee_rule.pc_unapproved_record.should_not be_nil
      record = pc_fee_rule.pc_unapproved_record
      # we are editing the U record, before it is approved
      pc_fee_rule.tier1_to_amt = 1000
      pc_fee_rule.save
      pc_fee_rule.reload
      pc_fee_rule.pc_unapproved_record.should == record
    end
    
    it "onupdate: should remove pc_unapproved_record if the approval_status changed from 'U' to 'A' (approval)" do
      pc_fee_rule = Factory(:pc_fee_rule)
      pc_fee_rule.reload
      pc_fee_rule.pc_unapproved_record.should_not be_nil
      # the approval process changes the approval_status from U to A for a newly edited record
      pc_fee_rule.approval_status = 'A'
      pc_fee_rule.save
      pc_fee_rule.reload
      pc_fee_rule.pc_unapproved_record.should be_nil
    end
    
    it "ondestroy: should remove pc_unapproved_record if the record with approval_status 'U' was destroyed (approval) " do
      pc_fee_rule = Factory(:pc_fee_rule)
      pc_fee_rule.reload
      pc_fee_rule.pc_unapproved_record.should_not be_nil
      record = pc_fee_rule.pc_unapproved_record
      # the approval process destroys the U record, for an edited record 
      pc_fee_rule.destroy
      PcUnapprovedRecord.find_by_id(record.id).should be_nil
    end
  end

  context "approve" do 
    it "should approve unapproved_record" do 
      pc_fee_rule = Factory(:pc_fee_rule, :approval_status => 'U')
      pc_fee_rule.approve.should == ""
      pc_fee_rule.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      pc_fee_rule = Factory(:pc_fee_rule, :approval_status => 'A')
      pc_fee_rule2 = Factory(:pc_fee_rule, :approval_status => 'U', :approved_id => pc_fee_rule.id, :approved_version => 6)
      pc_fee_rule2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      pc_fee_rule1 = Factory(:pc_fee_rule, :approval_status => 'A')
      pc_fee_rule2 = Factory(:pc_fee_rule, :approval_status => 'U')
      pc_fee_rule1.enable_approve_button?.should == false
      pc_fee_rule2.enable_approve_button?.should == true
    end
  end
  
  context "min_and_max_sc_amt" do
    it "should return error when min_sc_amt > max_sc_amt" do
      pc_fee_rule1 = Factory.build(:pc_fee_rule, :tier1_min_sc_amt => 50, :tier1_max_sc_amt => 40)
      pc_fee_rule1.save.should == false
      pc_fee_rule1.errors[:base].should == ["Tier 1 Minimum SC Amount should be less than Maximum SC Amount"]
      pc_fee_rule2 = Factory.build(:pc_fee_rule, :tier2_min_sc_amt => 50, :tier2_max_sc_amt => 40)
      pc_fee_rule2.save.should == false
      pc_fee_rule2.errors[:base].should == ["Tier 2 Minimum SC Amount should be less than Maximum SC Amount"]
      pc_fee_rule3 = Factory.build(:pc_fee_rule, :tier3_min_sc_amt => 50, :tier3_max_sc_amt => 40)
      pc_fee_rule3.save.should == false
      pc_fee_rule3.errors[:base].should == ["Tier 3 Minimum SC Amount should be less than Maximum SC Amount"]
    end
  end
end
