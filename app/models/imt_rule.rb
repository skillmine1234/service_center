class ImtRule < ActiveRecord::Base
  include Approval
  include ImtApproval

  belongs_to :created_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key => 'updated_by', :class_name => 'User'

  validates_presence_of :stl_gl_account, :chargeback_gl_account, :lock_version, :approval_status
  validates :stl_gl_account, :chargeback_gl_account, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}' }, length: {maximum: 16}
end
