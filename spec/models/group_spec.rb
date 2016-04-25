require 'spec_helper'

describe Group do
  context "model_list" do 
    it "should return array of model list" do 
      group = Factory(:group,:name => 'inward-remittance')
      group.model_list.should == ['Partner','Bank','PurposeCode','WhitelistedIdentity','InwIdentity','InwardRemittance', 'InwRemittanceRule','InwUnapprovedRecord', "IncomingFile"]

      group = Factory(:group,:name => 'e-collect')
      group.model_list.should == ['EcolUnapprovedRecord','EcolRule','EcolCustomer','EcolRemitter','EcolTransaction','UdfAttribute','IncomingFile','EcolFetchStatistic','QgEcolTodaysNeftTxn','QgEcolTodaysRtgsTxn']

      group = Factory(:group,:name => 'instant-credit')
      group.model_list.should == ['IncomingFile','IcIncomingRecord','IncomingFileRecord','IcCustomer','IcSupplier','IcUnapprovedRecord','IcInvoice','FmAuditStep','IcIncomingFile']

      group = Factory(:group,:name => 'e-collect')
      group.model_list.should == ['EcolUnapprovedRecord','EcolRule','EcolCustomer','EcolRemitter','EcolTransaction','UdfAttribute','IncomingFile','EcolFetchStatistic','QgEcolTodaysNeftTxn','QgEcolTodaysRtgsTxn']
    end
  end
end
