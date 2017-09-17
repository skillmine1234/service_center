require 'spec_helper'

describe IcolValidateStep do
  context 'association' do
    it { should belong_to(:icol_customer) }
  end
end