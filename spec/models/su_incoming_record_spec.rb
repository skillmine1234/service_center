require 'spec_helper'

describe SuIncomingRecord do
  context 'association' do
    it { should belong_to(:incoming_file_record) }
    it { should belong_to(:incoming_file) }
    it { should have_many(:su_audit_steps) }
  end
end