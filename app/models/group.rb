class Group < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_groups

  def model_list
    case name
    when "inward-remittance"
      ['EncryptedPassword','Partner','Bank','PurposeCode','WhitelistedIdentity','InwIdentity','InwardRemittance', 'InwRemittanceRule','InwUnapprovedRecord','IncomingFile']
    when "e-collect"
      ['EncryptedPassword','EcolUnapprovedRecord','EcolRule','EcolCustomer','EcolRemitter','EcolTransaction','UdfAttribute','IncomingFile','EcolFetchStatistic','QgEcolTodaysNeftTxn','QgEcolTodaysRtgsTxn']
    when "bill-management"
      ['EncryptedPassword','BmRule','BmBiller','BmBillPayment','BmAggregatorPayment','BmApp','BmUnapprovedRecord']
    when "prepaid-card"
      ['EncryptedPassword','PcApp','PcFeeRule','PcUnapprovedRecord']
    when "flex-proxy"
      ['EncryptedPassword','FpOperation','FpAuthRule','FpUnapprovedRecord']
    when "imt"
      ['EncryptedPassword','ImtCustomer','ImtTransfer','IncomingFile','ImtUnapprovedRecord','OutgoingFile']
    when "funds-transfer"
      ['EncryptedPassword','FundsTransferCustomer','FtUnapprovedRecord', 'ReconciledReturn']
    else
      []
    end
  end

end