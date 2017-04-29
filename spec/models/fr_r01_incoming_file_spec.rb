require 'spec_helper'

describe FrR01IncomingFile do
  context 'association' do
    it { should have_one(:incoming_file) }
  end
end