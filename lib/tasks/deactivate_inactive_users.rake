namespace :inactive_users do
  desc "Deactivate Last 6 Months Inactive Users"
  task :deactivate_inactive_users, [:arg1] => :environment do |t, args|
    @users = User.where(['last_sign_in_at < ? and inactive = ?', args[:arg1].to_i.days.ago,false]).where.not(last_sign_in_at: nil)
    puts "Deactive User Script Started......"
    @users.each do |user|
    	user.update(inactive: true,updated_at: Time.now)
    	puts "Deactivating User with id --> #{user.id}"
    end
    puts "End of the script,Total Users Deactivated:#{@users.size}"
  end

  desc "Dormancy Code Update"
  task :domancy_code_update => :environment do
     @users = User.where(['last_sign_in_at < ? and inactive = ?', "90".to_i.days.ago,false]).where.not(last_sign_in_at: nil)
     puts "Dormancy User Script Started......"
     @users.each do |user|
      user.update(dormancy: "Y",inactive: true,updated_at: Time.now)
      puts "Dormancy applied to the users with id --> "
     end
  end
end