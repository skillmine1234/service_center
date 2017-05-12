class BmApp < ActiveRecord::Base
  include Approval
  include BmApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :app_id, :channel_id, :needs_otp
  
  validates_uniqueness_of :app_id, :scope => :approval_status

  validates :flex_user_id, :flex_narrative_prefix, length: {maximum: 50}, presence: true, :if => :flex_fields_enabled?

  def flex_fields_enabled?
    is_configuration_global == 'N' ? true : false
  end
  
end