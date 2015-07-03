exit if ENV['SKIP_INIT'] == 'yes'

envs = ["DEVISE_AUTHENTICATE_WITH_LDAP","CONFIG_URL_AML_SEARCH","FROM_EMAIL_ID","SMTP_ADDRESS","SMTP_USERNAME","SMTP_PASSWORD","CONFIG_UPLOAD_PATH", "CONFIG_FILE_UPLOAD_PATH","CONFIG_LOGO_PATH","CONFIG_APPROVED_FILE_UPLOAD_PATH"]
results = []
envs.each do |v|
  results << v unless ENV.include?(v)
end
raise "The following environment variables are not set: #{results.join(' , ')}" unless results.empty?