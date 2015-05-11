require 'spec_helper'

describe WhitelistedIdentity do
  context 'association' do
    it { should have_many(:attachments)}
  end

  context 'validation' do
    [:partner_id, :is_verified, :created_by, :updated_by].each do |att|
      it { should validate_presence_of(att) }
    end
  end
end