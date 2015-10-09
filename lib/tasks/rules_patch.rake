namespace :rule do
  desc "create a record in rules table"
  task :create_record => :environment do
    InwRemittanceRule.create!(:pattern_salutations => "Mr,Mrs,Miss,Dr,Ms,PRof,Rev,Lady,Sir,Capt,Major,LtCol,Col")
  end
end

namespace :job do
  desc "Create Incoming File"
  task :create_incoming_file => :environment do
    Rails.logger.info "Creating Incoming File: " + Time.zone.now
    IncomingFile.create_incoming_file
  end
end