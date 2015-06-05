exit if ENV['SKIP_INIT'] == 'yes'

envs = ["DEVISE_AUTHENTICATE_WITH_LDAP","CONFIG_URL_AML_SEARCH","FROM_EMAIL_ID","SMTP_ADDRESS","SMTP_USERNAME","SMTP_PASSWORD"]
results = []
envs.each do |v|
  results << v unless ENV.include?(v)
end
raise "The following environment variables are not set: #{results.join(' , ')}" unless results.empty?