namespace :delete_group do
  desc "Delete Group"
  task :delete_group_and_update_description, [:names] => :environment do |t, args|
    @groups_to_be_deleted = args[:names].split(" ")
    puts @groups_to_be_deleted.inspect
    puts "Delete Group Script Started......"
      @groups_to_be_deleted.each do |group|
    	gr = Group.find_by(name: group)
    	if gr.present?
    		puts "Deleting Group with id --> #{gr.id}"
    		user_group = UserGroup.where(group_id: gr.id).destroy_all
    		gr.delete
    	end
    end

    #When we don't want to run Delete Group Script use following:-
    #rake delete_group:delete_group_and_update_description["abc"]

    # puts "Updating Group Description Script Started......"
    # old_name = ["bill-management","Obdx","cnb","e-collect","flex-proxy","funds-transfer","gm","iam","icol","imt","instant-credit","inward-remittance","ns","payByCreditCard","prepaid-card","prepaid-card2",
    #   "recurring-transfer","reverse-proxy","rp","rpl","rr","salary-upload","sc-backend","smb","es","dpesb","ctl","rpv1"]
    # new_name = ["Bill Management","Bill Management 2.0","Corporate NetBanking","E-collect","Flex Proxy","Fund Transfer","Gem","I AM","I collect","Instant Money Transfer","Instant Credit",
    #   "Inward Remittance","Notification Service","Pay by Credit Card","Prepaid card","Prepaid card 2","Recurring Transfer","Reverse proxy","Reports","Ripple",
    #   "Reconcile return","Salary Upload","Service Center backend","Sub Member Bank","Email Setup","Dp Esb Mapper","Catalogue","Reports - AML"]
    # old_name.each_with_index do |group_old_name,index|
    #   puts "#{group_old_name} --- #{new_name[index]}"
    #   record = Group.where(name: group_old_name).first
    #   if record.present?
    #     record.update(description: new_name[index])
    #   end
    #end
    puts "End of the script"  
  end
end