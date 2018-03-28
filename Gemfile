source 'https://rubygems.org'
ruby "2.2.2"
gem 'roo'
gem "flot-rails"
gem 'rails', '4.2.2'
gem 'haml-rails'
gem "devise", ">= 2.2.3"
gem 'cancancan', '~> 1.10'
gem 'mime-types'
gem "rolify", ">= 3.2.0"
gem "devise_ldap_authenticatable", '0.6.1'
gem 'will_paginate'
gem 'jquery-rails', '4.3.1'
gem 'carrierwave'
gem 'nested_form'
gem 'simple_form'
gem 'whenever', :require => false
gem 'acts_as_commentable', '3.0.1'
gem 'stringex'
gem 'activeadmin',  '~> 1.0.0.pre1'
gem "state_machine", "~> 1.2.0"
gem 'sunspot_rails'
gem 'rufus-scheduler'
gem 'simple-navigation'
gem 'progress_bar', '~> 1.0.0'
gem 'chosen-rails', '1.0.0'
gem 'turnout'
gem 'delayed_job_active_record'
gem 'rools', '0.4.1', :git=>'https://github.com/quantiguous/rools'
gem 'devise_security_extension'
gem 'secure_headers'
gem 'acts_as_list'
gem 'activeadmin-sortable'
gem 'therubyracer'
gem "daemons"
gem "audited-activerecord"
gem 'httparty'
gem 'zeroclipboard-rails'
gem 'country_select', github: 'stefanpenner/country_select'
gem 'faraday'
# required for packaging (specifically asset precompilation during packaging)
gem "sqlite3"
gem 'florrick', '~> 1.1'
gem 'unscoped_associations'
gem 'lazy_columns', :git=>'https://github.com/quantiguous/lazy_columns.git'
gem 'seed-fu'
gem 'net-scp'
gem 'rp', :github => 'quantiguous/rp'
gem 'approval2', '0.1.7'
gem 'passgen'
gem "mustache"
gem 'simple_enum'
gem 'simple_enum-multiple'

gem 'draper'
gem 'font-awesome-rails'

source "https://-p72Ximzp5o1QKVqLPgc@repo.fury.io/qg-ci/" do
  gem 'qg-icol', '1.1.5'
  gem 'qg-ecol', '1.5.5'
  gem 'qg-bm', '1.0.3'
  gem 'qg-asba', '1.0.2'
  gem 'qg-sm', '1.0.3'
  gem 'qg-ssp', '1.0.8'
  gem 'qg-imt', '1.1.11'
  gem 'qg-fp', '1.0.6'
  gem 'qg-ft', '1.2.5'
  gem 'qg-sc', '1.1.3'
  gem 'qg-gm', '1.1.6'
  gem 'qg-cc', '1.2.3'
  gem 'qg-cp', '1.0.2'
  gem 'qg-ae', '1.0.1'
  gem 'qg-ns', '1.0.3'
end

# oracle is required only in production, CI tools run against sqlite3
group :production do
  gem 'activerecord-oracle_enhanced-adapter',:git => 'git://github.com/rsim/oracle-enhanced.git'
  gem 'ruby-oci8'
  gem 'bcdatabase'
  gem 'passenger'
  gem 'rails_12factor'
  gem 'ruby-plsql'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier', '>= 1.0.3'
end


group :development, :test do
  gem 'sunspot_solr'
  gem 'dotenv-rails'
  gem "rspec"
  gem 'rspec-rails', "2.14.0"
  gem 'rb-readline'
  gem "factory_girl", "2.2.0"
  gem "shoulda-matchers"
  gem 'database_cleaner', '< 1.1.0'
  gem 'timecop'
  gem 'simplecov', :require => false
  gem 'simplecov-rcov', :require => false
  gem "unicorn"
  gem 'rake', '< 11.0'
  gem 'test-unit'
  gem 'cucumber-rails', :require => false
  gem 'selenium-webdriver'
  gem 'faker'
  gem 'flexmock'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-ext'
end

group :test do
  gem 'webmock'
  gem "codeclimate-test-reporter", group: :test, require: nil
end

gem 'newrelic_rpm'
