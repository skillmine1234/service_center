require 'spec_helper'

describe ScUnapprovedRecordsHelper do
  context "filter_records" do 
    it "should return records" do
      sc_unapproved_record = Factory(:sc_unapproved_record, :sc_approvable_type => 'ScBackend')
      filter_records(ScUnapprovedRecord,{}).should eq([{:record_type=>"ScBackend", :record_count=>1}])
    end
  end
end

