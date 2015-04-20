# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :remittance_review do
    transaction_id "MyString"
    justification_code "MyString"
    justification_text "MyString"
    review_status "MyString"
    reviewd_at "2015-04-20"
    review_remarks "MyString"
    reviewd_by "MyString"
    created_by "MyString"
    updated_by "MyString"
    lock_version 1
  end
end
