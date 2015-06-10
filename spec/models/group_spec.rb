require 'spec_helper'

describe Group do
  context "model_list" do 
    it "should return array of model list" do 
      group = Factory(:group,:name => 'inward-remittance')
      group.model_list.should == ['Partner','Bank','PurposeCode','WhitelistedIdentity','InwIdentity','InwardRemittance', 'InwRemittanceRule']
      group = Factory(:group,:name => 'e-collect')
      group.model_list.should == ['EcolRule','EcolCustomer']
    end
  end
end
