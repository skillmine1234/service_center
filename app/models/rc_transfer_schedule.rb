class RcTransferSchedule < ActiveRecord::Base  
  include Approval
  include RcTransferApproval

  self.table_name = "rc_transfer_schedule"

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  belongs_to :rc_transfer, :foreign_key => 'code', :primary_key => 'rc_transfer_code'

  validates_presence_of :code, :debit_account_no, :bene_account_no, :app_code, :notify_mobile_no, :is_enabled

  validates :code, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}' }, length: {minimum: 3, maximum: 15}
  validates :debit_account_no, :bene_account_no, format: {with: /\A[0-9]+\z/, :message => 'Invalid format, expected format is : {[0-9]}' }, length: {minimum: 15, maximum: 20}
  validates :app_code, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: {minimum: 5, maximum: 20}
  validates :notify_mobile_no, :numericality => {:only_integer => true}, length: {minimum: 10, maximum: 10}

  validates_uniqueness_of :code, :scope => :approval_status

  def next_run_at_value
    next_run_at.nil? ? Time.zone.now.try(:strftime, "%d/%m/%Y %I:%M%p") : next_run_at.try(:strftime, "%d/%m/%Y %I:%M%p")
  end
end
