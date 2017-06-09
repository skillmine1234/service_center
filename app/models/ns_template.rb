class NsTemplate < ActiveRecord::Base
  include Approval2::ModelAdditions

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  belongs_to :sc_event

  validates_presence_of :sc_event_id
  validates_uniqueness_of :sc_event_id, :scope => :approval_status
  validate :presence_of_template
  validate :presence_of_email_subject
  validate :validate_template

  def presence_of_template
    errors.add(:base, 'Either SMS or Email should be present') if sms_text.to_s.empty? && email_body.to_s.empty?
    errors.add(:email_body, 'should be present when email subject is not empty') if email_body.to_s.empty? && !email_subject.to_s.empty?
  end

  def presence_of_email_subject
    errors.add(:email_subject, 'should be present when email body is not emmpty') if !email_body.to_s.empty? && email_subject.to_s.empty?
  end

  def validate_template
    ["sms_text","email_body"].each do |template|
      error_msg = ""
      begin
        Mustache::Template.new(send(template)).tokens unless send(template).nil?
      rescue Mustache::Parser::SyntaxError => e
        error_msg = e.message
      end
      errors.add(template.to_sym,error_msg) unless error_msg.to_s.empty?
    end
  end

  def self.render_template(template,options)
    Mustache.render(template,options)
  end
end