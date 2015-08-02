require 'spec_helper'
describe InwUnapprovedRecord do
  context 'association' do
    it { should belong_to(:inw_approvable) }
  end
end