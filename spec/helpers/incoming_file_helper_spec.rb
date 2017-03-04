require 'spec_helper'

describe IncomingFileHelper do
  
  context "find_incoming_files" do 
    it "should return incoming files" do
      file_type = Factory(:incoming_file_type, :code => '1234')
      incoming_file = Factory(:incoming_file, :file_type => '1234',:approval_status => 'A')
      find_incoming_files({:file_type => "1234", :sc_service => incoming_file.service_name}).should == [incoming_file]
      find_incoming_files({:file_type=> "CUST01", :sc_service => incoming_file.service_name}).should == [] 

      incoming_file = Factory(:incoming_file, :file_name => 'Process Type',:approval_status => 'A')
      find_incoming_files({:file_name => "process", :sc_service => incoming_file.service_name}).should == [incoming_file]
      find_incoming_files({:file_name => "CUST01", :sc_service => incoming_file.service_name}).should == [] 
    end
  end
end
