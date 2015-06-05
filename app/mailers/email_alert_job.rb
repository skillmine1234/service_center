class EmailAlertJob < Struct.new(:content, :subject, :to, :recipient)
  def perform
    EmailNotificationMailer.notify_mail(content, subject, to).deliver
  end

  def after(job)
    Delayed::Worker.logger.debug("Recipients: #{to}")
  end
end