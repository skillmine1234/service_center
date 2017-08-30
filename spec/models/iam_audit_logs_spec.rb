require 'spec_helper'
describe IamAuditLog do
  include HelperMethods

  context 'association' do
    it { should belong_to(:iam_organisation) }
  end
end