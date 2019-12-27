namespace :inactive_users do
  desc "Deactivate Last 6 Months Inactive Users"
  task :deactivate_inactive_users, [:arg1] => :environment do |t, args|
    @users = User.where(['last_sign_in_at < ? and inactive = ?', args[:arg1].to_i.days.ago,false])
    puts "Script Started......"
    @users.each do |user|
    	user.update(inactive: true) 
    	puts "Updating User with id --> #{user.id}"
    end
    puts "End of the script,Total #{@users.size}"
  end
end