require 'spec_helper'

describe Partner do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context 'validation' do
    [:code, :name, :account_no, :txn_hold_period_days].each do |att|
      it { should validate_presence_of(att) }
    end
    it {should validate_numericality_of(:low_balance_alert_at)}
    it do
      partner = Factory(:partner, :account_no => '1234567890123456', :account_ifsc => 'abcd0123456',)
      should validate_uniqueness_of(:code)
    end
  
    it { should ensure_length_of(:account_no).is_at_least(10) }
    it { should ensure_length_of(:account_no).is_at_most(16) }
    it { should validate_numericality_of(:account_no) }
  end
  
  context 'account_ifsc' do
    it "should allow only alpha numeric characters" do 
      customer = Factory.build(:partner, :account_ifsc => 'abcd0123456', :account_no => '1234567890123456')
      customer.should be_valid
      customer.errors_on(:account_ifsc).should == []
      customer = Factory.build(:partner, :account_ifsc => 'abcd01234bh', :account_no => '1234567890123456')
      customer.should be_valid
      customer.errors_on(:account_ifsc).should == []
      customer = Factory.build(:partner, :account_ifsc => 'abcd11234bh', :account_no => '1234567890123456')
      customer.should_not be_valid
      customer.errors_on(:account_ifsc).should == ["is invalid"]
      customer = Factory.build(:partner, :account_ifsc => 'abcdef', :account_no => '1234567890123456')
      customer.should_not be_valid
      customer.errors_on(:account_ifsc).should == ["is invalid"]
      customer = Factory.build(:partner, :account_ifsc => '123456', :account_no => '1234567890123456')
      customer.should_not be_valid
      customer.errors_on(:account_ifsc).should == ["is invalid"]
      customer = Factory.build(:partner, :account_ifsc => '123 456', :account_no => '1234567890123456')
      customer.should_not be_valid
      customer.errors_on(:account_ifsc).should == ["is invalid"]
    end
  end
end
