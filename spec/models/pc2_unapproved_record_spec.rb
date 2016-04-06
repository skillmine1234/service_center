require 'spec_helper'

describe Pc2UnapprovedRecord do
  context "associations" do
    it { should belong_to(:pc2_approvable) }
  end
end
