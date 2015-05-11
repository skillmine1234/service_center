# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    note "MyString"
    file ActionDispatch::Http::UploadedFile.new(:tempfile => File.new("#{Rails.root}/spec/fixtures/rails.png"), :filename => "rails.png")
    attachable nil
  end
end
