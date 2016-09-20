require 'spec_helper'

describe PcCustomer do
  context "associations" do
    it { should belong_to(:app) }
  end
end