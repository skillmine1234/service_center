class Group < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_groups

  def model_list
    case name
    when "inward-remittance"
      ['Partner','Bank','PurposeCode','WhitelistedIdentity','InwIdentity','InwardRemittance', 'InwRemittanceRule','IncomingFile','InwGuideline','PartnerLcyRate']
    when "e-collect"
      ['EcolRule','EcolCustomer','EcolRemitter','EcolTransaction','UdfAttribute','IncomingFile','EcolFetchStatistic','QgEcolTodaysNeftTxn','QgEcolTodaysRtgsTxn','QgEcolTodaysImpsTxn','QgEcolTodaysUpiTxn','OutgoingFile','EcolApp','EcolAppUdtable']
    when "bill-management"
      ['BmRule','BmBiller','BmBillPayment','BmAggregatorPayment','BmApp','BmUnapprovedRecord']
    when "prepaid-card"
      ['PcApp','PcProgram', 'PcProduct', 'PcFeeRule','PcUnapprovedRecord','PcMmCdIncomingRecord','IncomingFile','IncomingFileRecord','PcMmCdIncomingFile']
    when "prepaid-card2"
      ['Pc2App','Pc2CustAccount']
    when "flex-proxy"
      ['FpOperation','FpAuthRule','FpUnapprovedRecord']
    when "imt"
      ['ImtRule','ImtCustomer','ImtTransfer','IncomingFile','ImtUnapprovedRecord','OutgoingFile','ImtIncomingFile','ImtIncomingRecord']
    when "funds-transfer"
      ['FundsTransferCustomer','FtUnapprovedRecord', 'FtPurposeCode','FtIncomingRecord','IncomingFile','IncomingFileRecord','FtIncomingFile','FtCustomerAccount','FtApbsIncomingFile','FtApbsIncomingRecord']
    when "salary-upload"
      ['IncomingFile','SuCustomer','SuUnapprovedRecord','SuIncomingRecord','FmAuditStep','SuIncomingFile']
    when "instant-credit"
      ['IncomingFile','IcIncomingRecord','IncomingFileRecord','IcCustomer','IcSupplier','IcUnapprovedRecord','IcInvoice','FmAuditStep','IcIncomingFile','Ic001IncomingRecord','Ic001IncomingFile']
    when "smb"
      ['SmUnapprovedRecord','SmBank','SmBankAccount']
    when "cnb"
      ['CnUnapprovedRecord','IncomingFile','IncomingFileRecord','CnIncomingFile','CnIncomingRecord','Cnb2IncomingFile','Cnb2IncomingRecord']
    when "recurring-transfer"
      ['RcTransferUnapprovedRecord','RcTransfer','RcTransferSchedule','RcAuditStep','RcApp']
    when "sc-backend"
      ['ScBackend','ScJob','ScFaultCode','ScBackendResponseCode','ScBackendSetting']
    when "rr"
      ['RrUnapprovedRecord','IncomingFile','IncomingFileRecord','RrIncomingFile','RrIncomingRecord','ReconciledReturn']
    when "iam"
      ['IamAuditLog', 'IamAuditRule','IamCustUser','IamOrganisation']
    when "fr"
      ['IncomingFile','IncomingFileRecord','FrR01IncomingFile','FrR01IncomingRecord']
    when "ns"
      ['NsCallback', 'NsTemplate']
    when "ssp"
      ['SspBank', 'SspAuditStep']
    when "icol"
      ['IcolCustomer', 'IcolValidateStep', 'IcolNotification', 'IcolNotifyStep', 'IcolNotifyTransaction']
    else
      []
    end
  end
end