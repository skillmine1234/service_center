class FtPurposeCode < ActiveRecord::Base
  include Approval
  include FtApproval

  TRANSFER_TYPES = [['ANY','ANY'],['APBS','APBS']]
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :code, :description, :is_enabled
  validates :code, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}'}, length: {minimum: 2, maximum: 6}
  validates :description, format: {with: /\A[a-z|A-Z|0-9|\s|\.|\-]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\s|\.|\-]}'}

  validates_uniqueness_of :code, :scope => :approval_status
end