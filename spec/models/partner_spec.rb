require 'spec_helper'

describe Partner do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context 'validation' do
    [:code, :enabled, :name, :account_no, :txn_hold_period_days,
    :remitter_email_allowed, :remitter_sms_allowed,
    :beneficiary_email_allowed, :beneficiary_sms_allowed, :allow_imps, 
    :allow_neft, :allow_rtgs, :country].each do |att|
      it { should validate_presence_of(att) }
    end
    [:account_no, :low_balance_alert_at, :mmid, :mobile_no, :txn_hold_period_days].each do |att|
      it {should validate_numericality_of(att)}
    end
    it do
      partner = Factory(:partner, :account_no => '1234567890123456', :account_ifsc => 'abcd0123456')
      should validate_uniqueness_of(:code)
    end
  
    it { should validate_length_of(:account_no).is_at_least(10) }
    it { should validate_length_of(:account_no).is_at_most(16) }
    it { should validate_length_of(:mobile_no).is_at_least(10) }
    it { should validate_length_of(:mobile_no).is_at_most(10) }
    it { should validate_length_of(:mmid).is_at_least(7) }
    it { should validate_length_of(:mmid).is_at_most(7) }

    context "txn_hold_period_days" do 
      it "should accept value 1 to 15" do
        should allow_value(1).for(:txn_hold_period_days)
        should allow_value(15).for(:txn_hold_period_days)
      end

      it "should not accept value other than 1 to 15" do
        should_not allow_value(0).for(:txn_hold_period_days)
        should_not allow_value(16).for(:txn_hold_period_days)
      end
    end

    context "low_balance_alert_at" do 
      it "should accept following values" do
        should allow_value(0).for(:low_balance_alert_at)
        should allow_value('9e20'.to_f).for(:low_balance_alert_at)
      end

      it "should not accept following values" do
        should_not allow_value(-1).for(:low_balance_alert_at)
        should_not allow_value('9e21'.to_f).for(:low_balance_alert_at)
      end
    end

    context "code format" do
      it "should allow valid format" do 
        [:code,:name].each do |att|
          should allow_value('a12232424V').for(att)
          should allow_value('abcddfgdfg').for(att)
          should allow_value('1234545435').for(att)
          should allow_value('aBCDdfdsgs').for(att)
        end
      end

      it "should not allow invalid format" do 
        [:code,:name].each do |att|
          should_not allow_value('ab*dsgdsgf').for(att)
          should_not allow_value('@acddsfdfd').for(att)
          should_not allow_value('134\ndsfdsg').for(att)
        end
      end
    end
  
    context 'account_ifsc' do
      it "should allow only alpha numeric characters" do 
        partner = Factory.build(:partner, :account_ifsc => 'abcd0123456', :account_no => '1234567890123456')
        partner.should be_valid
        partner.errors_on(:account_ifsc).should == []
        partner = Factory.build(:partner, :account_ifsc => 'abcd01234bh', :account_no => '1234567890123456')
        partner.should be_valid
        partner.errors_on(:account_ifsc).should == []
        partner = Factory.build(:partner, :account_ifsc => nil, :account_no => '1234567890123456')
        partner.should be_valid
        partner.errors_on(:account_ifsc).should == []
        partner = Factory.build(:partner, :account_ifsc => 'abcd11234bh', :account_no => '1234567890123456')
        partner.should_not be_valid
        partner.errors_on(:account_ifsc).should == ["is invalid"]
        partner = Factory.build(:partner, :account_ifsc => 'abcdef', :account_no => '1234567890123456')
        partner.should_not be_valid
        partner.errors_on(:account_ifsc).should == ["is invalid"]
        partner = Factory.build(:partner, :account_ifsc => '123456', :account_no => '1234567890123456')
        partner.should_not be_valid
        partner.errors_on(:account_ifsc).should == ["is invalid"]
        partner = Factory.build(:partner, :account_ifsc => '123 456', :account_no => '1234567890123456')
        partner.should_not be_valid
        partner.errors_on(:account_ifsc).should == ["is invalid"]
      end
    end

    context "imps_and_mmid" do 
      it "should validate if mmid if imps is true" do 
        partner = Factory.build(:partner, :mmid => nil, :allow_imps => 'Y')
        partner.should_not be_valid
        partner.errors_on("mmid").should == ["is mandatory"]
      end

      it "should validate if mobile_no if imps is true" do 
        partner = Factory.build(:partner, :mobile_no => nil, :allow_imps => 'Y')
        partner.should_not be_valid
        partner.errors_on("mobile_no").should == ["is mandatory"]
      end
    end

    context "check_email_addresses" do 
      it "should validate email address" do 
        partner = Factory.build(:partner, :tech_email_id => "1234;esesdgs", :ops_email_id => "1234;esesdgs")
        partner.should_not be_valid
        partner.errors_on("tech_email_id").should == ["are invalid due to 1234,esesdgs"]
        partner.errors_on("ops_email_id").should == ["are invalid due to 1234,esesdgs"]
        partner = Factory.build(:partner, :tech_email_id => "foo@ruby.com", :ops_email_id => "foo@ruby.com;bar@ruby.com")
        partner.should be_valid
      end
    end

    context "country_name" do 
      it "should return full name for the country code" do 
        partner = Factory.build(:partner, :country => 'US')
        partner.country_name.should == 'United States'
        partner = Factory.build(:partner, :country => nil)
        partner.country_name.should == nil
      end
    end
  end
end
