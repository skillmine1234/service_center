# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    note "MyString"
    file Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/rails.png')))
    attachable nil
  end
end
