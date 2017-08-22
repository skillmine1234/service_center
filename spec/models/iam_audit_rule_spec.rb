require 'spec_helper'

describe IamAuditRule do

  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
  end

  context "validation" do
    [:org_uuid, :cert_dn, :source_ip, :interval_in_mins].each do |att|
      it { should validate_presence_of(att) }
    end

    it { should validate_numericality_of(:interval_in_mins) }

  end
end
