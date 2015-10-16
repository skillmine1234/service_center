require 'spec_helper'

describe BmRule do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_one(:bm_unapproved_record) }
    it { should belong_to(:unapproved_record) }
    it { should belong_to(:approved_record) }
  end

  context 'validation' do
    [:cod_acct_no, :customer_id, :bene_acct_no, :bene_account_ifsc, :neft_sender_ifsc, :lock_version, :approval_status].each do |att|
      it { should validate_presence_of(att) }
    end

    it "should validate_unapproved_record" do
      bm_rule1 = Factory(:bm_rule,:approval_status => 'A')
      bm_rule2 = Factory(:bm_rule, :approved_id => bm_rule1.id)
      bm_rule1.should_not be_valid
      bm_rule1.errors_on(:base).should == ["Unapproved Record Already Exists for this record"]
    end

    context "fields format" do
      it "should allow valid format" do
        [:cod_acct_no, :customer_id, :bene_acct_no].each do |att|
          should allow_value('aaAAbbBB00').for(att)
          should allow_value('AAABBBC090').for(att)
          should allow_value('aaa0000bn').for(att)
          should allow_value('0123456789').for(att)
          should allow_value('AAAAAAAAAA').for(att)
        end
      end

      it "should not allow invalid format" do
        bm_rule = Factory.build(:bm_rule, :cod_acct_no => '-1dfghhhhh', :customer_id => '@,.9023jsf', :bene_acct_no => '(*&^%^)')
        bm_rule.save == false
        [:cod_acct_no, :customer_id, :bene_acct_no].each do |att|
          bm_rule.errors_on(att).should == ["Invalid format, expected format is : {[a-z|A-Z|0-9]}"]
        end
      end
    end
  end

  context "ifsc format" do
    [:bene_account_ifsc, :neft_sender_ifsc].each do |att|
      it "should allow valid format" do
        should allow_value('ABCD0QWERTY').for(att)
      end
    end

    #TODO: write in loop i.e. for each
    it "should not allow invalid format" do
      bm_rule1 = Factory.build(:bm_rule, :bene_account_ifsc => 'abcd0QWERTY')
      bm_rule1.errors_on(:bene_account_ifsc).should == ["Invalid format, expected format is : {[A-Z]{4}[0][A-Z|0-9]{6}}"]
      bm_rule1 = Factory.build(:bm_rule, :bene_account_ifsc => 'abcdQWERTY')
      bm_rule1.errors_on(:bene_account_ifsc).should == ["Invalid format, expected format is : {[A-Z]{4}[0][A-Z|0-9]{6}}"]
      bm_rule1 = Factory.build(:bm_rule, :bene_account_ifsc => 'ab0QWER')
      bm_rule1.errors_on(:bene_account_ifsc).should == ["Invalid format, expected format is : {[A-Z]{4}[0][A-Z|0-9]{6}}"]

      bm_rule2 = Factory.build(:bm_rule, :neft_sender_ifsc => 'abcd0QWERTY')
      bm_rule2.errors_on(:neft_sender_ifsc).should == ["Invalid format, expected format is : {[A-Z]{4}[0][A-Z|0-9]{6}}"]
      bm_rule2 = Factory.build(:bm_rule, :neft_sender_ifsc => 'abcdQWERTY')
      bm_rule2.errors_on(:neft_sender_ifsc).should == ["Invalid format, expected format is : {[A-Z]{4}[0][A-Z|0-9]{6}}"]
      bm_rule2 = Factory.build(:bm_rule, :neft_sender_ifsc => 'ab0QWER')
      bm_rule2.errors_on(:neft_sender_ifsc).should == ["Invalid format, expected format is : {[A-Z]{4}[0][A-Z|0-9]{6}}"]
    end
  end

  context "default_scope" do
    it "should only return 'A' records by default" do
      bm_rule1 = Factory(:bm_rule, :approval_status => 'A')
      bm_rule2 = Factory(:bm_rule)
      BmRule.all.should == [bm_rule1]
      bm_rule2.approval_status = 'A'
      bm_rule2.save
      BmRule.all.should == [bm_rule1, bm_rule2]
    end
  end

  context "create_bm_unapproved_records" do
    it "should create bm_unapproved_record if the approval_status is 'U' and there is no previous record" do
      bm_rule = Factory(:bm_rule)
      bm_rule.reload
      bm_rule.bm_unapproved_record.should_not be_nil
      record = bm_rule.bm_unapproved_record
      bm_rule.save
      bm_rule.bm_unapproved_record.should == record
    end

    it "should not create bm_unapproved_record if the approval_status is 'A'" do
      bm_rule = Factory(:bm_rule, :approval_status => 'A')
      bm_rule.bm_unapproved_record.should be_nil
    end
  end

  context "remove_bm_unapproved_records" do
    it "should remove bm_unapproved_record if the approval_status is 'A' and there is unapproved_record" do
      bm_rule = Factory(:bm_rule)
      bm_rule.reload
      bm_rule.bm_unapproved_record.should_not be_nil
      record = bm_rule.bm_unapproved_record
      bm_rule.save
      bm_rule.bm_unapproved_record.should == record
      bm_rule.approval_status = 'A'
      bm_rule.save
      bm_rule.remove_bm_unapproved_records
      bm_rule.reload
      bm_rule.bm_unapproved_record.should be_nil
    end
  end

  context "approve" do
    it "should approve unapproved_record" do
      bm_rule = Factory(:bm_rule, :approval_status => 'U')
      bm_rule.approve.should == ""
      bm_rule.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do
      bm_rule = Factory(:bm_rule, :approval_status => 'A')
      bm_rule2 = Factory(:bm_rule, :approval_status => 'U', :approved_id => bm_rule.id, :approved_version => 6)
      bm_rule2.approve.should == "The record version is different from that of the approved version"
    end
  end

  context "enable_approve_button?" do
    it "should return true if approval_status is 'U' else false" do
      bm_rule1 = Factory(:bm_rule, :approval_status => 'A')
      bm_rule2 = Factory(:bm_rule, :approval_status => 'U')
      bm_rule1.enable_approve_button?.should == false
      bm_rule2.enable_approve_button?.should == true
    end
  end
end
