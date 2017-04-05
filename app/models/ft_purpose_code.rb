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
  
  before_save :set_allow_only_registered_bene, if: "allowed_transfer_type == 'APBS'"

  def set_allow_only_registered_bene
    self.allow_only_registered_bene = 'N' unless self.frozen?
  end
end