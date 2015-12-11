class Group < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_groups

  def model_list
    case name
    when "inward-remittance"
      ['Partner','Bank','PurposeCode','WhitelistedIdentity','InwIdentity','InwardRemittance', 'InwRemittanceRule','InwUnapprovedRecord']
    when "e-collect"
      ['EcolUnapprovedRecord','EcolRule','EcolCustomer','EcolRemitter','EcolTransaction','UdfAttribute','IncomingFile','EcolFetchStatistic']
    when "bill-management"
      ['BmRule','BmBiller','BmBillPayment','BmAggregatorPayment','BmApp','BmUnapprovedRecord']
    when "prepaid-card"
      ['PcApp','PcFeeRule','PcUnapprovedRecord']
    when "flex-proxy"
      ['FpOperation','FpAuthRule','FpUnapprovedRecord']
    else
      []
    end
  end

end