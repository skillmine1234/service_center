require 'spec_helper'

describe IcolNotification do
  context 'association' do
    it { should have_many(:icol_notify_steps) }
  end
end