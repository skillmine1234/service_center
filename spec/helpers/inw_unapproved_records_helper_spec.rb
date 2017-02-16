require 'spec_helper'

describe InwUnapprovedRecordsHelper do
  context "filter_records" do 
    it "should return records" do
      inw_unapproved_record = Factory(:inw_unapproved_record, :inw_approvable_type => 'Partner')
      filter_records(InwUnapprovedRecord).should eq([{:record_type=>"Partner", :record_count=>1}, {:record_type=>"Bank", :record_count=>0}, {:record_type=>"PurposeCode", :record_count=>0}, {:record_type=>"WhitelistedIdentity", :record_count=>0},{:record_type=>"InwRemittanceRule", :record_count=>0}, {:record_type=>"IncomingFile", :record_count=>0}, {:record_type=>"InwGuideline", :record_count=>0}])
    end
  end
end