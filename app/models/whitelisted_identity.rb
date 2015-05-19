class WhitelistedIdentity < ActiveRecord::Base
  has_many :attachments, :as => :attachable

  accepts_nested_attributes_for :attachments

  validates_presence_of :partner_id, :is_verified, :created_by, :updated_by
end
