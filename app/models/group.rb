class Group < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_groups

  def model_list
    case name
    when "inward-remittance"
      ['Partner','Bank','PurposeCode','WhitelistedIdentity','InwIdentity','InwardRemittance', 'InwRemittanceRule','IncomingFile','InwGuideline','PartnerLcyRate']
    when "e-collect"
      Qg::Ecol::MODELS
    when "bill-management"
      Qg::Bm::MODELS
    when "prepaid-card"
      ['PcApp','PcProgram', 'PcProduct', 'PcFeeRule','PcUnapprovedRecord','PcMmCdIncomingRecord','IncomingFile','IncomingFileRecord','PcMmCdIncomingFile']
    when "prepaid-card2"
      ['Pc2App','Pc2CustAccount']
    when "flex-proxy"
      Qg::Fp::MODELS
    when "imt"
      Qg::Imt::MODELS
    when "funds-transfer"
      Qg::Ft::MODELS
    when "salary-upload"
      ['IncomingFile','SuCustomer','SuUnapprovedRecord','SuIncomingRecord','FmAuditStep','SuIncomingFile']
    when "instant-credit"
      ['IncomingFile','IcIncomingRecord','IncomingFileRecord','IcCustomer','IcSupplier','IcUnapprovedRecord','IcInvoice','FmAuditStep','IcIncomingFile','Ic001IncomingRecord','Ic001IncomingFile']
    when "smb"
      Qg::Sm::MODELS
    when "cnb"
      ['CnUnapprovedRecord','IncomingFile','IncomingFileRecord','CnIncomingFile','CnIncomingRecord','Cnb2IncomingFile','Cnb2IncomingRecord']
    when "recurring-transfer"
      ['RcTransferUnapprovedRecord','RcTransfer','RcTransferSchedule','RcAuditStep','RcApp']
    when "sc-backend"
      Qg::Sc::MODELS
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
      Qg::Icol::MODELS
    when "asba"
      Qg::Asba::MODELS
    when "payByCreditCard"
      Qg::Cc::MODELS
    when "gm"
      Qg::Gm::MODELS
    when "cinepolis"
      Qg::Cp::MODELS
    when "account-enquiry"
      Qg::Ae::MODELS
    else
      []
    end
  end
end