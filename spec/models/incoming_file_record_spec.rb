require 'spec_helper'

describe IncomingFileRecord do
  context 'association' do
    it { should belong_to(:incoming_file) }
    it { should have_many(:fm_audit_steps) }
  end
end
