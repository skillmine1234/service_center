module IdentitiesHelper
  def find_identities(params)
    identities = WhitelistedIdentity.joins(:partner)
    identities = identities.where("partners.code=?",params[:code]) if params[:code].present?
    identities = identities.where("full_name=?",params[:name]) if params[:name].present?
    identities = identities.where("bene_account_no=?",params[:bene_account_no]) if params[:bene_account_no].present?
    identities = identities.where("bene_account_ifsc=?",params[:bene_account_ifsc]) if params[:bene_account_ifsc].present?
    identities = identities.where("rmtr_code=?",params[:rmtr_code]) if params[:rmtr_code].present?
    identities
  end
end