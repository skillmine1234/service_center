require 'spec_helper'

describe IcIncomingRecord do
  context 'association' do
    it { should belong_to(:incoming_file_record) }
    it { should belong_to(:incoming_file) }
    it { should have_many(:ic_audit_steps) }
  end
end