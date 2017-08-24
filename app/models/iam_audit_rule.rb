class IamAuditRule < ActiveRecord::Base
  audited
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  belongs_to :iam_organisation
  
  validates_presence_of :log_bad_org_uuid, :enabled_at, :interval_in_mins, :iam_organisation_id
  
  validate :enabled_at_should_be_today
  validates :interval_in_mins, :inclusion => 1..30
  
  before_validation :set_org_uuid, unless: "self.iam_organisation.nil?"
  
  private
  
  def enabled_at_should_be_today
    errors.add(:enabled_at, 'should be today') unless enabled_at.beginning_of_day == Time.zone.today.beginning_of_day
  end
  
  def set_org_uuid
    self.org_uuid = self.iam_organisation.org_uuid
  end
end
