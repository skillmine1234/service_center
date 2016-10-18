require 'spec_helper'
describe ScUnapprovedRecord do
  context 'association' do
    it { should belong_to(:sc_approvable) }
  end
end