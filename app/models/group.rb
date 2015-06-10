class Group < ActiveRecord::Base
  def model_list
    case name
    when "inward-remittance"
      ['Partner','Bank','PurposeCode','WhitelistedIdentity','InwIdentity','InwardRemittance', 'InwRemittanceRule']
    else
      []
    end
  end
end