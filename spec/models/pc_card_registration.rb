require 'spec_helper'

describe PcCardRegistration do
  context "associations" do
    it { should belong_to(:app) }
  end
end