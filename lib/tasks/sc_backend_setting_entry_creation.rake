namespace :obdx_backend_setting do
  desc "Entry Creation into ObdxBackendSetting"
  
  task :create_dummy_entry => :environment do
  	obdx_backend_setting = ObdxBackendSetting.new
  	obdx_backend_setting.backend_code = 'FCR'
  	obdx_backend_setting.service_code = 'BPS'
  	obdx_backend_setting.app_id = nil
  	obdx_backend_setting.setting1_name = 'userId'
  	obdx_backend_setting.setting1_type = 'text'
  	obdx_backend_setting.setting1_value = 'TESTVALUE'
  	obdx_backend_setting.setting2_name = 'narrativePrefix'
  	obdx_backend_setting.setting2_type = 'text'
  	obdx_backend_setting.setting2_value = 'TESTVALUE'
  	obdx_backend_setting.is_std = 'Y'
  	obdx_backend_setting.is_enabled = 'Y'
  	obdx_backend_setting.created_by = 'testobdxuser'
  	obdx_backend_setting.approval_status = 'A'
	  if obdx_backend_setting.save!
    	puts "ObdxBackendSetting Entry created"
    else
    	puts "Error occurred in creating entry for ObdxBackendSetting"
    end
    puts "End of the script for Entry Creation in ObdxBackendSetting"
  end

  task :create_dummy_entry2_recuring_transfer => :environment do
    s = ScBackend.new
      s.code = 'SC_RCT'
      s.do_auto_shutdown = 'N'
      s.do_auto_start = 'N'
      s.window_in_mins = 5 
      s.url = "https://10.0.45.87:1443/AccountManagementExt/GetCASADetailsExt"
      s.http_username = "testclient"
      s.http_password = "OxYcool@123"
      s.max_consecutive_failures = 3
      s.min_consecutive_success = 3 
      s.max_window_failures = 5
      s.min_window_success = 6
      s.created_by = 'Q'
      s.created_at = Time.zone.now
      s.approval_status = 'A'
      
      if s.save!
        puts "Sc Backend Entry created for Recuring Transfer API call"
      else
        puts "Error occurred in creating entry for Recuring Transfer API call"
      end
      puts "End of the script of  Recuring Transfer API call Entry Creation"
  end

end