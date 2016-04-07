require 'spec_helper'

describe Pc2UnapprovedRecordsHelper do
  context "filter_records" do 
    it "should return records" do
      pc2_unapproved_record = Factory(:pc2_unapproved_record, :pc2_approvable_type => 'Pc2App')
      filter_records(Pc2UnapprovedRecord).should eq([{:record_type=>"Pc2App", :record_count=>1}])
    end
  end
end
