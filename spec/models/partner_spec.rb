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
      partner = Factory(:partner)
      should validate_uniqueness_of(:code)
    end
  end
end
