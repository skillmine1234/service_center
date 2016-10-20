module IdentitiesHelper
  def find_identities(params)
    identities = WhitelistedIdentity.joins(:partner)
    identities = identities.where("partners.code=?",params[:code]) if params[:code].present?
    identities = identities.where("full_name=?",params[:name]) if params[:name].present?
    identities
  end
end