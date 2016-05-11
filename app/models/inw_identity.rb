class InwIdentity < ActiveRecord::Base
  # attr_accessible :id_country, :id_expiry_date, :id_issue_date, :id_number, :id_for, :id_type, 
  #                 :inw_remittance_id

  belongs_to :inward_remittance, :foreign_key => 'inw_remittance_id'

  validates :id_type, length: { maximum: 30 }
  
  def whitelisted_identity
    WhitelistedIdentity.where("id_type=? and id_number=? and id_country=? and id_issue_date=? and id_expiry_date=? and is_verified=?", id_type,id_number,id_country,id_issue_date,id_expiry_date,'Y').first rescue nil
  end

  def is_verified
    whitelisted_identity.nil? ? 'N' : 'Y'
  end

  def verified_by
    whitelisted_identity.nil? ? '-' : whitelisted_identity.verified_by
  end

  def verified_at
    whitelisted_identity.nil? ? '-' : whitelisted_identity.verified_at.strftime("%d/%m/%Y %I:%M%p")
  end

  def full_name
    id_for == "R" ? inward_remittance.rmtr_full_name : inward_remittance.bene_full_name
  end
end
