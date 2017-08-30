require 'spec_helper'

describe IamAuditRule do

  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should belong_to(:iam_organisation) }
  end

  context "validation" do
    [:log_bad_org_uuid, :enabled_at, :interval_in_mins].each do |att|
      it { should validate_presence_of(att) }
    end

    it { should validate_inclusion_of(:interval_in_mins).in_array((1..30).to_a) }

    it "should validate enabled_at should be today's date" do
      rule = Factory.build(:iam_audit_rule, enabled_at: Time.zone.now - 24.hour)
      rule.valid?.should == false
      rule.errors_on(:enabled_at).should == ["should be today"]
    end
  end
end
