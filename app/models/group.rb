class Group < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_groups

  def model_list
    case name
    when "inward-remittance"
      ['Partner','Bank','PurposeCode','WhitelistedIdentity','InwIdentity','InwardRemittance', 'InwRemittanceRule','InwUnapprovedRecord','IncomingFile','InwGuideline']
    when "e-collect"
      ['EcolUnapprovedRecord','EcolRule','EcolCustomer','EcolRemitter','EcolTransaction','UdfAttribute','IncomingFile','EcolFetchStatistic','QgEcolTodaysNeftTxn','QgEcolTodaysRtgsTxn','QgEcolTodaysImpsTxn','OutgoingFile','EcolApp']
    when "bill-management"
      ['BmRule','BmBiller','BmBillPayment','BmAggregatorPayment','BmApp','BmUnapprovedRecord']
    when "prepaid-card"
      ['PcApp','PcProgram', 'PcProduct', 'PcFeeRule','PcUnapprovedRecord','PcMmCdIncomingRecord','IncomingFile','IncomingFileRecord','PcMmCdIncomingFile']
    when "prepaid-card2"
      ['Pc2App','Pc2UnapprovedRecord']
    when "flex-proxy"
      ['FpOperation','FpAuthRule','FpUnapprovedRecord']
    when "imt"
      ['ImtCustomer','ImtTransfer','IncomingFile','ImtUnapprovedRecord','OutgoingFile']
    when "funds-transfer"
      ['FundsTransferCustomer','FtUnapprovedRecord', 'ReconciledReturn', 'FtPurposeCode','FtIncomingRecord','IncomingFile','IncomingFileRecord','FtIncomingFile','FtCustomerAccount']
    when "salary-upload"
      ['IncomingFile','SuCustomer','SuUnapprovedRecord','SuIncomingRecord','FmAuditStep','SuIncomingFile']
    when "instant-credit"
      ['IncomingFile','IcIncomingRecord','IncomingFileRecord','IcCustomer','IcSupplier','IcUnapprovedRecord','IcInvoice','FmAuditStep','IcIncomingFile']
    when "smb"
      ['SmUnapprovedRecord','SmBank','SmBankAccount']
    when "cnb"
      ['CnUnapprovedRecord','IncomingFile','IncomingFileRecord','CnIncomingFile','CnIncomingRecord']
    when "recurring-transfer"
      ['RcTransferUnapprovedRecord','RcTransfer','RcTransferSchedule','RcAuditStep','RcApp']
    when "sc-backend"
      ['ScBackend', 'ScUnapprovedRecord']
    else
      []
    end
  end
end