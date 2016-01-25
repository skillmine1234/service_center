require 'spec_helper'

describe FtUnapprovedRecordsHelper do
  context "filter_records" do 
    it "should return records" do
      ft_unapproved_record = Factory(:ft_unapproved_record, :ft_approvable_type => 'FundsTransferCustomer')
      filter_records(FtUnapprovedRecord).should eq([{:record_type=>"FundsTransferCustomer", :record_count=>1}])
    end
  end
end
