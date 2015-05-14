require 'spec_helper'

describe InwardRemittancesLock do
  context 'association' do
    it { should have_one(:partner) }
    it { should have_one(:inward_remittance) }
  end

  context 'validation' do
    [:partner_code, :req_no].each do |att|
      it { should validate_uniqueness_of(att) }
    end
  end
end
