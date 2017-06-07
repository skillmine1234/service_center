# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :atom_customer, class: Atom::Customer do
    sequence(:accountno) {|n| "abcd0" + "%06i" % "#{n}" }
    mobileno '9999999900'
    mmid 'MyString'
  end
end