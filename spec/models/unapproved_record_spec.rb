require 'spec_helper'
describe UnapprovedRecord do
  context 'association' do
    it { should belong_to(:approvable) }
  end
end
