require 'spec_helper'

describe ReconciledReturn do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context 'validation' do
    [:txn_type, :return_code, :settlement_date, :bank_ref_no, :reason].each do |att|
      it { should validate_presence_of(att) }
    end
  end

end
