SPEC_SUITES = [{ :id => :service_center, :title => 'Service Center', :pattern => "spec/" }]

Bundler.load.specs.select { |x| x.name.start_with?('qg-') }.each do |engine|
  SPEC_SUITES << { :id => engine.name.to_sym, :title => engine.summary, :pattern => "#{engine.full_gem_path}/spec/" }
end

namespace :spec do
  namespace :suite do
    SPEC_SUITES.each do |suite|
      desc "Run all specs in #{suite[:title]} spec suite"
      task "#{suite[:id]}" do
        Rake::Task["spec:suite:#{suite[:id]}:run"].execute
      end
      RSpec::Core::RakeTask.new("#{suite[:id]}:run") do |t|
        t.pattern = suite[:pattern]
        t.verbose = false
        t.fail_on_error = false
      end
    end
    desc "Run all spec suites"
    task :all => :environment do
      failed_suites = []
      SPEC_SUITES.each do |suite|
        puts "Running spec:suite:#{suite[:id]} ..."
        Rake::Task["spec:suite:#{suite[:id]}"].execute
        failed_suites << suite unless $?.success?
      end
      raise "Spec suite failed!" unless failed_suites.empty?
    end
  end
end