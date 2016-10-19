class ScBackend < ActiveRecord::Base
  include Approval
  include ScApproval

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  has_one :sc_backend_stat, :foreign_key => "code", :primary_key => 'code'
  has_one :sc_backend_status, :foreign_key => "code", :primary_key => 'code'
  has_many :sc_backend_status_changes, :foreign_key => "code", :primary_key => 'code'
  accepts_nested_attributes_for :sc_backend_status_changes

  validates_presence_of :code, :do_auto_shutdown, :max_consecutive_failures, :window_in_mins, :max_window_failures, 
                        :do_auto_start, :min_consecutive_success, :min_window_success
  validates_uniqueness_of :code, :scope => :approval_status

  validates :code, length: { maximum: 20 }
  validates :do_auto_shutdown, length: { minimum: 1, maximum: 1 }
  validates :window_in_mins, length: { minimum: 1, maximum: 2 }
  validates_inclusion_of :window_in_mins, :in => [1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60], :message => "Allowed Values: 1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60"
  validates :do_auto_start, length: { minimum: 1, maximum: 1 }

  validate :failures_and_success
  validate :check_email_addresses

  def failures_and_success
    if !self.max_consecutive_failures.nil? || !self.min_consecutive_success.nil? || !self.max_window_failures.nil?
      if !(max_consecutive_failures <= min_consecutive_success) || !(min_consecutive_success <= max_window_failures)
        errors.add(:base, "Condition: Max Consecutive Failures <= Min Consecutive Success <= Max Window Failures")
      end
    end
  end

  def check_email_addresses
    ["alert_email_to"].each do |email_id|
      invalid_ids = []
      value = self.send(email_id)
      unless value.nil?
        value.split(/;\s*/).each do |email| 
          unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
            invalid_ids << email
          end
        end
      end
      errors.add(email_id.to_sym, "is invalid, expected format is abc@def.com") unless invalid_ids.empty?
    end
  end
end
