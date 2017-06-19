require 'spec_helper'

describe Group do
  context "model_list" do 
    it "should return array of model list" do 
      group = Factory(:group,:name => 'inward-remittance')
      group.model_list.should == ['Partner','Bank','PurposeCode','WhitelistedIdentity','InwIdentity','InwardRemittance', 'InwRemittanceRule', "IncomingFile", "InwGuideline", "PartnerLcyRate"]

      group = Factory(:group,:name => 'e-collect')
      group.model_list.should == ['EcolRule','EcolCustomer','EcolRemitter','EcolTransaction','UdfAttribute','IncomingFile','EcolFetchStatistic','QgEcolTodaysNeftTxn','QgEcolTodaysRtgsTxn','QgEcolTodaysImpsTxn', 'QgEcolTodaysUpiTxn', "OutgoingFile", "EcolApp", "EcolAppUdtable"]

      group = Factory(:group,:name => 'imt')
      group.model_list.should == ['ImtRule','ImtCustomer','ImtTransfer','IncomingFile','ImtUnapprovedRecord','OutgoingFile','ImtIncomingFile','ImtIncomingRecord']

      group = Factory(:group,:name => 'instant-credit')
      group.model_list.should == ['IncomingFile','IcIncomingRecord','IncomingFileRecord','IcCustomer','IcSupplier','IcUnapprovedRecord','IcInvoice','FmAuditStep','IcIncomingFile','Ic001IncomingRecord','Ic001IncomingFile']

      group = Factory(:group,:name => 'smb')
      group.model_list.should == ['SmUnapprovedRecord','SmBank','SmBankAccount']

      group = Factory(:group,:name => 'cnb')
      group.model_list.should == ['CnUnapprovedRecord','IncomingFile','IncomingFileRecord','CnIncomingFile','CnIncomingRecord','Cnb2IncomingFile','Cnb2IncomingRecord']

      group = Factory(:group,:name => 'recurring-transfer')
      group.model_list.should == ["RcTransferUnapprovedRecord", "RcTransfer", "RcTransferSchedule", "RcAuditStep", "RcApp"]

      group = Factory(:group,:name => 'sc-backend')
      group.model_list.should == ['ScBackend','ScJob','ScFaultCode','ScBackendResponseCode']
      
      group = Factory(:group,:name => 'fr')
      group.model_list.should == ['IncomingFile','IncomingFileRecord','FrR01IncomingFile','FrR01IncomingRecord']

      group = Factory(:group,:name => 'ns')
      group.model_list.should == ['NsCallback', 'NsTemplate']
    end
  end
end
