require 'spec_helper'

describe CnUnapprovedRecordsHelper do
  context "filter_records" do 
    it "should return records" do
      cn_unapproved_record = Factory(:cn_unapproved_record, :cn_approvable_type => 'IncomingFile')
      filter_records(CnUnapprovedRecord).should eq([{:record_type=>"IncomingFile", :record_count=>1}])
    end
  end
end
