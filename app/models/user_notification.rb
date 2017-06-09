module UserNotification  
  extend ActiveSupport::Concern
  included do
    after_save :add_user_to_ldap_on_approval
    after_save :delete_user_from_ldap_on_approval
  end

  def test_ldap_login
    LDAP.new.try_login(username, decrypted_password)
    "Login Successful"
  rescue LDAPFault, Psych::SyntaxError, SystemCallError, Net::LDAP::LdapError => e
    e.message
  end
  
  def resend_password
    notify = notify_customer('Password Generated')
    notify == true ? "Password has been resent successfully!" : notify
  rescue OCIError, ArgumentError => e
    e.message
  end
  
  def add_user_to_ldap
    LDAP.new.add_user(username, decrypted_password)
    notify = notify_customer('Password Generated')
    notify == true ? "Entry added successfully to LDAP for #{username} and notification sent!" : "Entry added successfully to LDAP for #{username}!"
  rescue LDAPFault, Psych::SyntaxError, SystemCallError, Net::LDAP::LdapError, OCIError, ArgumentError => e
    e.message
  end

  def delete_user_from_ldap
    if is_enabled == 'N'
      LDAP.new.delete_user(username)
      notify = notify_customer('Access Removed')
      notify == true ? "Entry deleted from LDAP for #{username} and notification sent!" : "Entry deleted from LDAP for #{username}!"
    end
  rescue LDAPFault, Psych::SyntaxError, SystemCallError, Net::LDAP::LdapError, OCIError, ArgumentError => e
    e.message
  end

  def add_user_to_ldap_on_approval
    if approval_status == 'A' && last_action == 'C'
      LDAP.new.add_user(username, generated_password)
      update_column(:was_user_added, 'Y')
      notify_customer('Password Generated') unless Rails.env.test?
    end
  rescue
    nil
  end

  def delete_user_from_ldap_on_approval
    if approval_status == 'A' && is_enabled == 'N' && is_enabled_was == 'Y'
      LDAP.new.delete_user(username)
      notify_customer('Access Removed')
    end
  rescue
    nil
  end

  def notify_customer(event)
    event = ScEvent.find_by_event(event)
    template = NsTemplate.find_by_sc_event_id_and_is_enabled(event.id,'Y') rescue nil
    unless template.nil?
      plsql.pk_qg_send_email.enqueue1(ENV['CONFIG_IIB_SMTP_BROKER_UUID'], self.email, NsTemplate.render_template(template.email_subject, template_variables(event)), NsTemplate.render_template(template.email_body, template_variables(event))) unless template.email_body.to_s.empty?
      plsql.pk_qg_send_sms.enqueue(ENV['CONFIG_IIB_SMTP_BROKER_UUID'], self.mobile_no, NsTemplate.render_template(template.sms_text, template_variables(event))) unless template.sms_text.to_s.empty?
      update_column(:notification_sent_at, Time.zone.now)
    else
      'Template is not setup for SMS / Email'
    end
  end

  def enable_resend_button?
    approval_status == 'A' ? true: false
  end
end