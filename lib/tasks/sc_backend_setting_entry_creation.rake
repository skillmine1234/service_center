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
end