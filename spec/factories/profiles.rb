# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    display_name "MyString"
    bio "MyText"
    image "MyString"
    website "MyString"
    date_of_birth "2014-05-27"
    location "MyString"
    user_id 1
    latitude 1.5
    longitude 1.5
  end
end
