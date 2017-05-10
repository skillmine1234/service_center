require 'spec_helper'

describe Ic001IncomingFile do
  context 'association' do
    it { should have_one(:incoming_file) }
  end
end