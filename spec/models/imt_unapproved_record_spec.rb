require 'spec_helper'
describe ImtUnapprovedRecord do
  context 'association' do
    it { should belong_to(:imt_approvable) }
  end
end