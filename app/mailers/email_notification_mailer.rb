class EmailNotificationMailer < ActionMailer::Base
  default :from => ENV['FROM_EMAIL_ID']
  default :template_path => 'mailers'

  def notify_mail(content, subject, email)
    @content = content
    mail(to: email , subject: subject)
  end
end
