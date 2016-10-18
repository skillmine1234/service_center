# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sc_backend do
    sequence(:code) {|n| "9" + "%03i" % "#{n}" }
    do_auto_shutdown "Y"
    max_consecutive_failures 4
    window_in_mins 8
    max_window_failures 1
    do_auto_start "N"
    min_consecutive_success 4
    min_window_success 1
    alert_email_to "def@ruby.com"
    approval_status "U"
    last_action "C"
  end
end