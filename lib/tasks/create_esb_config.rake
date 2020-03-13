namespace :ecol_file_path_entry_in_esb_config do
  desc "Ecol File Path Entry in EsbConfig"
  task :create_esb_config_ecol_file_path => :environment do
  	esb_config = EsbConfig.new
  	esb_config.s_no = EsbConfig.maximum(:s_no) + 1
	  esb_config.key = 'ecol_file_path'
	  esb_config.value = '/IIBFILES/ecol/ecol_rmtrs'
	  esb_config.created_date = Time.now
	  esb_config.created_user = 'ESB'
	  esb_config.updated_date = Time.now
	  esb_config.updated_user = 'ESB'
	  if esb_config.save!
    	puts "Ecol File path Entry created in EsbConfig"
    else
    	puts "Error occurred in creating entry for Ecol File path Entry in EsbConfig"
    end
    puts "End of the script for EsbConfig Ecol File path"
  end

  desc "Ecol File Path Entry in EsbConfig"
  task :create_record_display_period => :environment do
    esb_config = EsbConfig.new
    esb_config.s_no = EsbConfig.maximum(:s_no) + 1
    esb_config.key = 'record_display_period'
    esb_config.value = '30'
    esb_config.created_date = Time.now
    esb_config.created_user = 'ESB'
    esb_config.updated_date = Time.now
    esb_config.updated_user = 'ESB'
    if esb_config.save!
      puts "Ecol Record display created in EsbConfig"
    else
      puts "Error occurred in creating entry for Ecol Record display period in EsbConfig"
    end
    puts "End of the script for EsbConfig Record display period"
  end

end