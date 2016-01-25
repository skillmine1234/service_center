require 'spec_helper'

describe ReconciledReturnsHelper do
  context "find_reconciled_returns" do
    it "should find reconciled_returns" do
      reconciled_return = Factory(:reconciled_return, :bank_ref_no => '1234')
      find_reconciled_returns({:bank_ref_no => '1234'}).should == [reconciled_return]
      find_reconciled_returns({:bank_ref_no => '1111'}).should == []
    end
  end
end
