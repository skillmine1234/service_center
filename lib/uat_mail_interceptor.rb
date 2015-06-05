class UatMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject} #{message.cc}"
    message.to = ["hello@quantiguous.com"]
    message.cc = ""
  end
end
