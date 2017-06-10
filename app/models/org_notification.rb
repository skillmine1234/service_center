module OrgNotification  
  extend ActiveSupport::Concern
  included do
    after_save :send_notification_on_approval
  end

  def send_notification_on_approval
    if approval_status == 'A' && last_action == 'C'
      notify_customer('Org Setup Completed') unless Rails.env.test?
    end
  rescue
    nil
  end

  def resend_setup
    notify = notify_customer('Org Setup Completed')
    notify == true ? "Organisation setup has been resent succesfully!" : notify
  rescue OCIError, ArgumentError => e
    e.message
  end

  def notify_customer(event)
    event_id = ScEvent.find_by_event(event).try(:id)
    template = NsTemplate.find_by_sc_event_id_and_is_enabled(event_id,'Y') rescue nil
    unless template.nil?
      plsql.pk_qg_send_email.enqueue1(ENV['CONFIG_IIB_SMTP_BROKER_UUID'], self.email_id, NsTemplate.render_template(template.email_subject, template_variables), NsTemplate.render_template(template.email_body, template_variables)) unless template.email_body.to_s.empty?
      update_column(:notification_sent_at, Time.zone.now) if !template.email_body.to_s.empty?
    else
      'Template is not setup for SMS / Email'
    end
  end

  def enable_resend_button?
    approval_status == 'A' ? true: false
  end
end