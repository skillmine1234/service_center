require 'spec_helper'

describe FpUnapprovedRecordsHelper do
  context "filter_records" do 
    it "should return records" do
      fp_unapproved_record = Factory(:fp_unapproved_record, :fp_approvable_type => 'FpOperation')
      filter_records(FpUnapprovedRecord).should eq([{:record_type=>"FpOperation", :record_count=>1}, {:record_type=>"FpAuthRule", :record_count=>0}])
    end
  end
end
