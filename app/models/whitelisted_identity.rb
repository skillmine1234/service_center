class WhitelistedIdentity < ActiveRecord::Base
  has_many :attachments, :as => :attachable
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  accepts_nested_attributes_for :attachments

  validates_presence_of :partner_id, :is_verified, :created_by, :updated_by
end
