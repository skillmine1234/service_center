require 'spec_helper'

describe Partner do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context 'validation' do
    [:code, :name, :account_no, :account_ifsc, :txn_hold_period_days].each do |att|
      it { should validate_presence_of(att) }
    end
    
end
