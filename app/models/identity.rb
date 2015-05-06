class Identity < ActiveRecord::Base
  attr_accessible :created_by, :first_name, :full_name, :id_country, :id_expiry_date, 
                  :id_issue_date, :id_number, :id_req_type, :id_type, :is_verified, 
                  :last_name, :lock_version, :partner_id, :remittance_req_no, :updated_by, 
                  :verified_at, :verified_by
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  belongs_to :verified_user, :foreign_key =>'verified_by', :class_name => 'User'

  def whitelisted_identity
    WhitelistedIdentity.where("full_name =? and id_type=? and id_number=? and id_country=? and id_expiry_date=? and id_issue_date=? and is_verified=?", full_name,id_type,id_number,id_country,id_issue_date,id_expiry_date,'Y').first rescue nil
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
end
