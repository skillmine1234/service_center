require 'spec_helper'

describe PurposeCode do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context 'validation' do
    [:code, :description, :is_enabled, :txn_limit, :daily_txn_limit].each do |att|
      it { should validate_presence_of(att) }
    end
  end
  
  context 'disallowed_rem_and_bene_types'do
    it 'should be a string' do
      purpose_code = Factory(:purpose_code, :disallowed_bene_types => ["I","N"], :disallowed_rem_types => ["I","N"])
      purpose_code.disallowed_rem_types.should == "I,N"
      purpose_code.disallowed_bene_types.should == "I,N"
    end
  end
end