require 'spec_helper'
describe CnUnapprovedRecord do
  context 'association' do
    it { should belong_to(:cn_approvable) }
  end
end
