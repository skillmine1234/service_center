namespace :replace_file do
  desc "Replace Database.yml file"
  task :database_yml_file_replacement => :environment do
    puts "Starting the process to Replace database.yml file........"
    data = File.read("#{Rails.root}/packaging/database.yml.sample")
    # File.open("/Users/rubyistdhruv/Downloads/database.yml", "w"){|f| f.truncate(0)}
    # File.open("/Users/rubyistdhruv/Downloads/database.yml", "w"){|f| f.write(data)}
    File.open("/opt/service-center/config/database.yml", "w"){|f| f.truncate(0)}
    File.open("/opt/service-center/config/database.yml", "w"){|f| f.write(data)}
    puts "Replacement Activity for database.yml file Completed"
    # replaced_file_content = File.read("/Users/rubyistdhruv/Downloads/database.yml")
    replaced_file_content = File.read("/opt/service-center/config/database.yml")
    puts "After Replacement Content for database.yml file:- \n\n #{replaced_file_content}"
  end
end