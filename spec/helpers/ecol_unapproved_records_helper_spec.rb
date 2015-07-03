require 'spec_helper'

describe EcolUnapprovedRecordsHelper do
  context "filter_records" do 
    it "should return records" do
      ecol_unapproved_record = Factory(:ecol_unapproved_record, :ecol_approvable_type => 'EcolRule')
      filter_records(EcolUnapprovedRecord).should eq([{:record_type=>"EcolCustomer", :record_count=>0}, {:record_type=>"EcolRemitter", :record_count=>0}, {:record_type=>"UdfAttribute", :record_count=>0}, {:record_type=>"EcolRule", :record_count=>1}, {:record_type=>"IncomingFile", :record_count=>0}])
    end
  end
end
