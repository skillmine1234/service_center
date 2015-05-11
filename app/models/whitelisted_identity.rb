class WhitelistedIdentity < ActiveRecord::Base
  attr_accessible :created_by, :first_name, :first_used_with_txn_id, :full_name, :id_country, 
                  :id_issue_date, :id_expiry_date, :id_number, :id_type, :is_verified, :last_name, 
                  :last_used_with_txn_id, :lock_version, :partner_id, :times_used,
                  :updated_by, :verified_at, :verified_by, :attachments_attributes
  has_many :attachments, :as => :attachable

  accepts_nested_attributes_for :attachments

  validates_presence_of :partner_id, :is_verified, :created_by, :updated_by
end
