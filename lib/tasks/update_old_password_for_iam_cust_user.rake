namespace :replace_old_password do
  desc "Replace Encrypted Password with Old Password"
  puts "Replace Old Password Script"
  task :update_old_password_for_iam_cust_user => :environment do
    iam_cust_users = IamCustUser.where(old_password: nil).where.not(encrypted_password: nil)
    if iam_cust_users.present?
	    iam_cust_users.each do |iam_cust_user|
	    	iam_cust_user.update(old_password: iam_cust_user.encrypted_password)
	    	puts "Deactivating IamCustUser with id --> #{iam_cust_user.id}"
	   	end
	  end
	  puts "End of the script,Total IamCustUser Deactivated:#{iam_cust_users.size}"
  end
end

class IamCustUser < ActiveRecord::Base
	puts "Into iam_cust_user................."
end