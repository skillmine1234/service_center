require 'spec_helper'

describe ImtTransfersHelper do
  context "find_imt_transfers" do
    it "should find imt_transfers" do
      imt_transfer = Factory(:imt_transfer, :imt_ref_no => '1', :initiation_ref_no => '1', :customer_id => '1234')
      find_imt_transfers({:customer_id => '1234'}).should == [imt_transfer]
      find_imt_transfers({:customer_id => '1111'}).should == []
      
      imt_transfer = Factory(:imt_transfer, :imt_ref_no => '2', :initiation_ref_no => '2', :status_code => 'NEW')
      find_imt_transfers({:status => 'NEW'}).should == [imt_transfer]
      find_imt_transfers({:status => 'COMPLETED'}).should == []
      
      imt_transfer = [Factory(:imt_transfer, :imt_ref_no => '3', :initiation_ref_no => '3',:transfer_amount => '10000')]
      imt_transfer << Factory(:imt_transfer, :imt_ref_no => '4', :initiation_ref_no => '4',:transfer_amount => '9000')
      imt_transfer << Factory(:imt_transfer, :imt_ref_no => '5', :initiation_ref_no => '5',:transfer_amount => '8000')
      find_imt_transfers({:from_amount => '8000', :to_amount => '10000'}).should == imt_transfer
      find_imt_transfers({:from_amount => '10000', :to_amount => '12000'}).should == [imt_transfer[0]]
    end
  end
end
