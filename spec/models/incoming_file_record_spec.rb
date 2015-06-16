require 'spec_helper'

describe IncomingFileRecord do
  context 'association' do
    it { should belong_to(:incoming_file) }
  end
end
