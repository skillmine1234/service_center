# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :udf_attribute do
    
    class_name "EcolRemitter"
    attribute_name "udf1"
    is_enabled 'N'
    is_mandatory 'N'
    control_type 'CheckBox'
    select_options "---\n name1: value1"
  end

  factory :ecol_remitter_custom_field, :parent => :udf_attribute, :class => 'EcolRemitterCustomField' do
  end
end
