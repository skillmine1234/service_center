# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :su_incoming_record do
    incoming_file_record_id {Factory(:incoming_file_record, :incoming_file => Factory(:incoming_file)).id}
    file_name {Factory(:incoming_file).file_name}
    corp_account_no "12344"
    corp_ref_no "2324"
    corp_stmt_txt "MyText"
    emp_account_no "2324"
    emp_name "FooBar"
    emp_ref_no "2424"
    salary_amount 50000
    emp_stmt_txt "MyText"
    account_name "Foo"
    distance_in_name 30
  end
end
