class WhitelistedIdentity < ActiveRecord::Base
  include Approval
  include InwApproval
  
  has_many :attachments, :as => :attachable
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  belongs_to :inward_remittance, :foreign_key => 'first_used_with_txn_id', :class_name => 'InwardRemittance'
  belongs_to :partner

  accepts_nested_attributes_for :attachments

  validates_uniqueness_of :id_type, :scope => [:id_number,:id_country,:id_issue_date,:id_expiry_date,:approval_status]

  validates_presence_of :partner_id, :is_verified, :created_by, :updated_by, :id_type, :id_number, :id_expiry_date
  
  validate :validate_expiry_date

  after_create :update_identities

  def inw_identity
    inward_remittance.identities.where("id_type=? and id_number=? and id_country=? and id_issue_date=? and id_expiry_date=?", id_type,id_number,id_country,id_issue_date,id_expiry_date).first rescue nil
  end

  def update_identities
    inw_identity.update_attributes(:was_auto_matched => 'N',:whitelisted_identity_id => id) unless inw_identity.nil?
  end
  
  def validate_expiry_date
    errors.add(:id_expiry_date,"should not be less than today's date") if !id_expiry_date.nil? and id_expiry_date < Time.zone.today
  end
  
  def auto_match_and_release
    inw_identity = InwIdentity.find_by_id(self.created_for_identity_id)
    unless inw_identity.nil?
      if inw_identity.partner.auto_match_rule == 'N'
        ::WhitelistIdentityHelper.try_release(self.created_for_txn_id)
      else
        ::WhitelistIdentityHelper.auto_match_and_release(self.id)
      end
    end
  end
end