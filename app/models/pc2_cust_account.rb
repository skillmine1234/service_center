class Pc2CustAccount < ActiveRecord::Base
  include Approval2::ModelAdditions
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  belongs_to :pc2_app, :foreign_key => 'customer_id', :primary_key => 'customer_id'

  validates :customer_id, presence: true, :numericality => {:only_integer => true, :message => 'Invalid format, expected format is : {[0-9]}'}, length: { maximum: 15 }
  validates :account_no, presence: true, :numericality => {:only_integer => true, :message => 'Invalid format, expected format is : {[0-9]}'}, length: { minimum: 5, maximum: 20 }
  validates :is_enabled, presence: true, length: { minimum: 1, maximum: 1 }

  validates_uniqueness_of :customer_id, :scope => [:account_no, :approval_status]

  validate :validate_customer_id

  def validate_customer_id
    pc2_apps = Pc2App.where("customer_id = ? and is_enabled = ?", customer_id, 'Y')
    errors.add(:customer_id, "not valid") if pc2_apps.empty?
  end
end
