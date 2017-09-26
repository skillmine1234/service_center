ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require 'webmock/rspec'
require "codeclimate-test-reporter"
require 'database_cleaner'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

require File.expand_path("../../config/environment", __FILE__)

Bundler.load.specs.select { |x| x.name.start_with?('qg-') }.each do |engine|
  FactoryGirl.definition_file_paths << "#{engine.full_gem_path}/spec/factories"
end

FactoryGirl.find_definitions

RSpec.configure do |config|


  config.mock_with :flexmock

  config.use_transactional_fixtures = true

  config.infer_base_class_for_anonymous_controllers = false

  config.include Devise::TestHelpers, :type => :controller
    
  dbs = [ DatabaseCleaner[:active_record, { :connection => :fcr_test }],
          DatabaseCleaner[:active_record, { :connection => :fcatrt_test }],
          DatabaseCleaner[:active_record, { :connection => :atom_test }],
          DatabaseCleaner[:active_record, { :connection => :upi_test }],
          DatabaseCleaner[:active_record, { :connection => :invxp_test }],
          DatabaseCleaner[:active_record, { :connection => :test }]
        ]

  config.before(:suite) do
    begin
      dbs.each do |db|
        db.strategy = :truncation
        db.start
      end
    ensure
      dbs.each do |db|
        db.clean
      end
    end
  end    
end

module DisableFlashSweeping
  def sweep
  end
end