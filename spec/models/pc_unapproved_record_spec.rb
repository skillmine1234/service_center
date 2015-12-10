require 'spec_helper'

describe PcUnapprovedRecord do
  context "associations" do
    it { should belong_to(:pc_approvable) }
  end
end
