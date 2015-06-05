class WhitelistedIdentity < ActiveRecord::Base
  has_many :attachments, :as => :attachable
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  belongs_to :inward_remittance, :foreign_key => 'first_used_with_txn_id', :class_name => 'InwardRemittance'

  accepts_nested_attributes_for :attachments


  validates_presence_of :partner_id, :is_verified, :created_by, :updated_by

  after_create :update_identities

  def inw_identity
    inward_remittance.identities.where("id_type=? and id_number=? and id_country=? and id_issue_date=? and id_expiry_date=?", id_type,id_number,id_country,id_issue_date,id_expiry_date).first rescue nil
  end

  def update_identities
    inw_identity.update_attributes(:was_auto_matched => 'N',:whitelisted_identity_id => id) unless inw_identity.nil?
  end
end
