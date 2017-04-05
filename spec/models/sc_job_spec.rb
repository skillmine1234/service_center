require 'spec_helper'

describe ScJob do
  context 'association' do
    it { should belong_to(:sc_service) }
  end
end