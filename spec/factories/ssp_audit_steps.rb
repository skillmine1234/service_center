# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ssp_audit_step do
    step_name "Validate"
    status_code "Success"
    app_code "APP123"
    customer_code "CUST123"
    req_timestamp "2017-01-01"
    req_bitstream "<xml/>"
  end
end