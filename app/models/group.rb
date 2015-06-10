class Group < ActiveRecord::Base
  def model_list
    case name
    when "inward-remittance"
      ['Partner','Bank','PurposeCode','WhitelistedIdentity','InwIdentity','InwardRemittance', 'InwRemittanceRule']
    when "e-collect"
      ['EcolRule','EcolCustomer']
    else
      []
    end
  end
end