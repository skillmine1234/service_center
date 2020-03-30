namespace :update_display_record_period do
  desc "Configure Record display period"
  task :set_ecol_display_record_period, [:arg1] => :environment do |t, args|
    @esb_config = EsbConfig.find_by(key: "record_display_period")
    if @esb_config.present?
      @esb_config.update(value: args[:arg1])
      puts "Updated EsbConfig with id --> #{@esb_config.id}"
      puts "EsbConfig value --> #{@esb_config.value}"
    else
      puts "No Record Present"
    end
    puts "End of the script for updating EsbConfig Record display period"
  end
end