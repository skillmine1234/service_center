exit if ENV['SKIP_INIT'] == 'yes'

envs = ["DEVISE_AUTHENTICATE_WITH_LDAP","CONFIG_URL_AML_SEARCH"]
results = []
envs.each do |v|
  results << v unless ENV.include?(v)
end
raise "The following environment variables are not set: #{results.join(' , ')}" unless results.empty?