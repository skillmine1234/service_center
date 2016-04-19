# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ic_invoice do
    sequence(:corp_customer_id) {|n| "#{n}" }
    sequence(:supplier_code) {|n| "#{n}" }
    sequence(:invoice_no) {|n| "9" + "%03i" % "#{n}" }
    invoice_date "2016-04-07"
    invoice_due_date "2016-04-07"
    invoice_amount "99999.99"
    fee_amount "9.99"
    discounted_amount "9.99"
    credit_date "2016-04-07"
    credit_ref_no "MyString"
    pm_utr "MyString"
    repaid_amount "9.99"
    repayment_date "2016-04-07"
    repayment_ref_no "MyString"
  end
end
