# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ic_incoming_record do
    incoming_file_record_id {Factory(:incoming_file_record, :incoming_file => Factory(:incoming_file,:file_type => 'PAYNOW',:service_name => 'INSTANTCREDIT')).id}
    file_name {Factory(:incoming_file).file_name}
    supplier_code "SU1234"
    invoice_no "1234"
    invoice_date Time.zone.today
    invoice_due_date Time.zone.today.advance(:days => 1)
    invoice_amount 1200
    debit_ref_no "12345"
    corp_customer_id "12345"
    pm_utr "DF123"
  end
end