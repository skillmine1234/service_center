class Group < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_groups

  def model_list
    case name
    when "inward-remittance"
      ['Partner','Bank','PurposeCode','WhitelistedIdentity','InwIdentity','InwardRemittance', 'InwRemittanceRule','InwUnapprovedRecord','IncomingFile']
    when "e-collect"
      ['EcolUnapprovedRecord','EcolRule','EcolCustomer','EcolRemitter','EcolTransaction','UdfAttribute','IncomingFile','EcolFetchStatistic','QgEcolTodaysNeftTxn','QgEcolTodaysRtgsTxn']
    when "bill-management"
      ['BmRule','BmBiller','BmBillPayment','BmAggregatorPayment','BmApp','BmUnapprovedRecord']
    when "prepaid-card"
      ['PcApp','PcFeeRule','PcUnapprovedRecord']
    when "prepaid-card2"
      ['Pc2App','Pc2UnapprovedRecord']
    when "flex-proxy"
      ['FpOperation','FpAuthRule','FpUnapprovedRecord']
    when "imt"
      ['ImtCustomer','ImtTransfer','IncomingFile','ImtUnapprovedRecord','OutgoingFile']
    when "funds-transfer"
      ['FundsTransferCustomer','FtUnapprovedRecord', 'ReconciledReturn']
    when "salary-upload"
      ['IncomingFile','SuCustomer','SuUnapprovedRecord','SuIncomingRecord']
    when "instant-credit"
      ['IcCustomer','IcSupplier','IcUnapprovedRecord','IcInvoice']
    else
      []
    end
  end

end