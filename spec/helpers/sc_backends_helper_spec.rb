require 'spec_helper'

describe ScBackendsHelper do
  context "find_sc_backends" do
    it "should find sc_backends" do
      sc_backend = Factory(:sc_backend, :code => "8877", :approval_status => "A")
      find_sc_backends({:code => '8877'}).should == [sc_backend]
      find_sc_backends({:code => '8876'}).should == []
      find_sc_backends({:code => '887'}).should == []
    end
  end  
end
