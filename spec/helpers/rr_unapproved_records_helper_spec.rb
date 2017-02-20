require 'spec_helper'

describe RrUnapprovedRecordsHelper do
  context "filter_records" do 
    it "should return records" do
      rr_unapproved_record = Factory(:rr_unapproved_record, :rr_approvable_type => 'IncomingFile')
      filter_records(RrUnapprovedRecord).should eq([{:record_type=>"IncomingFile", :record_count=>1}])
    end
  end
end
