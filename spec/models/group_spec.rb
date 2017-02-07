require 'spec_helper'

describe Group do
  context "model_list" do 
    it "should return array of model list" do 
      group = Factory(:group,:name => 'inward-remittance')
      group.model_list.should == ['Partner','Bank','PurposeCode','WhitelistedIdentity','InwIdentity','InwardRemittance', 'InwRemittanceRule','InwUnapprovedRecord', "IncomingFile", "InwGuideline"]

      group = Factory(:group,:name => 'e-collect')
      group.model_list.should == ['EcolUnapprovedRecord','EcolRule','EcolCustomer','EcolRemitter','EcolTransaction','UdfAttribute','IncomingFile','EcolFetchStatistic','QgEcolTodaysNeftTxn','QgEcolTodaysRtgsTxn','QgEcolTodaysImpsTxn', "OutgoingFile"]

      group = Factory(:group,:name => 'instant-credit')
      group.model_list.should == ['IncomingFile','IcIncomingRecord','IncomingFileRecord','IcCustomer','IcSupplier','IcUnapprovedRecord','IcInvoice','FmAuditStep','IcIncomingFile']

      group = Factory(:group,:name => 'smb')
      group.model_list.should == ['SmUnapprovedRecord','SmBank','SmBankAccount']

      group = Factory(:group,:name => 'cnb')
      group.model_list.should == ['CnUnapprovedRecord','IncomingFile','IncomingFileRecord','CnIncomingFile','CnIncomingRecord']

      group = Factory(:group,:name => 'recurring-transfer')
      group.model_list.should == ["RcTransferUnapprovedRecord", "RcTransfer", "RcTransferSchedule", "RcAuditStep", "RcApp"]

      group = Factory(:group,:name => 'sc-backend')
      group.model_list.should == ['ScBackend','ScUnapprovedRecord']
    end
  end
end
